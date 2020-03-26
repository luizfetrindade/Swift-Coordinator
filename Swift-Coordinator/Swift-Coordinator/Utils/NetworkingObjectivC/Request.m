//
//  Request.m
//  Swift-Coordinator
//
//  Created by Fabricio Pujol on 25/03/20.
//  Copyright © 2020 Luiz Felipe Trindade. All rights reserved.
//

#import "Request.h"

@implementation Request

//singleton
+(instancetype)sharedRequestManager{
    static Request *sharedRequestManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedRequestManager = [[self alloc]init];
    });
    return sharedRequestManager;
}



- (void)fetchNowPlaying: (id<RequestProtocol>)delegate {
    NSLog(@"Fecthing Now Playing");
    NSString *urlString = @"https://api.themoviedb.org/3/movie/now_playing?api_key=ec133e4315b807c11f344060f8b97991&language=en-US&page=1";

    NSURL *url = [NSURL URLWithString:urlString];

    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        NSLog(@"finished Fecthing NowPlaying...");

        NSError *err;
        NSArray *nowPlayingJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];

        if(err){
            NSLog(@"Failed to serialize into JSON: %@", err);
            return;
        }

        NSMutableArray <Movie *> *movies = NSMutableArray.new;

        for (NSDictionary *nowPlayingDict in [nowPlayingJSON valueForKey:@"results"]) {
            NSString *title = nowPlayingDict[@"original_title"];
            NSString *overview = nowPlayingDict[@"overview"];
            NSString *backdrop = nowPlayingDict[@"backdrop_path"];
            NSString *movieId = nowPlayingDict[@"id"];
            NSString *language = nowPlayingDict[@"original_language"];
            NSString *posterPath = nowPlayingDict[@"poster_path"];
            NSMutableArray *genres = nowPlayingDict[@"genre_ids"];
            NSNumber *popularity = nowPlayingDict[@"popularity"];
            NSNumber *voteAverage = nowPlayingDict[@"vote_average"];
            NSNumber *voteCount = nowPlayingDict[@"vote_count"];

            Movie *movie = Movie.new;
            movie.vote_count = voteCount;
            movie.vote_average = voteAverage;
            movie.popularity = popularity;
            movie.poster_path = posterPath;
            movie.original_language = language;
            movie.original_title = title;
            movie.overview = overview;
            movie.backdrop_path = backdrop;
            movie.pk_id = movieId;
            movie.genre_ids = genres;
            [movies addObject:movie];
        }

        [delegate didRetrieveResponse:movies forRequest:@"NowPlaying"];
    }] resume];
}

- (void)fetchPopular: (id<RequestProtocol>)delegate {
    NSLog(@"Fecthing Now Playing");
    NSString *urlString = @"https://api.themoviedb.org/3/movie/popular?api_key=ec133e4315b807c11f344060f8b97991&language=en-US&page=1";

    NSURL *url = [NSURL URLWithString:urlString];

    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        NSLog(@"finished Fecthing NowPlaying...");

        NSError *err;
        NSArray *nowPlayingJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];

        if(err){
            NSLog(@"Failed to serialize into JSON: %@", err);
            return;
        }

        NSMutableArray <Movie *> *movies = NSMutableArray.new;

        for (NSDictionary *nowPlayingDict in [nowPlayingJSON valueForKey:@"results"]) {
            NSString *title = nowPlayingDict[@"original_title"];
            NSString *overview = nowPlayingDict[@"overview"];
            NSString *backdrop = nowPlayingDict[@"backdrop_path"];
            NSString *movieId = nowPlayingDict[@"id"];
            NSString *language = nowPlayingDict[@"original_language"];
            NSString *posterPath = nowPlayingDict[@"poster_path"];
            NSMutableArray *genres = nowPlayingDict[@"genre_ids"];
            NSNumber *popularity = nowPlayingDict[@"popularity"];
            NSNumber *voteAverage = nowPlayingDict[@"vote_average"];
            NSNumber *voteCount = nowPlayingDict[@"vote_count"];

            Movie *movie = Movie.new;
            movie.vote_count = voteCount;
            movie.vote_average = voteAverage;
            movie.popularity = popularity;
            movie.poster_path = posterPath;
            movie.original_language = language;
            movie.original_title = title;
            movie.overview = overview;
            movie.backdrop_path = backdrop;
            movie.pk_id = movieId;
            movie.genre_ids = genres;
            [movies addObject:movie];
        }
        [delegate didRetrieveResponse:movies forRequest:@"PopularMovies"];
    }] resume];
}

- (void)fetchGenres: (int) id request:(id<RequestProtocol>) delegate {
    NSLog(@"Fecthing Genres");
    NSString* idString = [@(id) stringValue];
    NSString *urlString = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@?api_key=ec133e4315b807c11f344060f8b97991&language=en-US", idString];

    NSURL *url = [NSURL URLWithString:urlString];

    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        NSLog(@"finished Fecthing Genres");

        NSError *err;
        NSArray *nowPlayingJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];

        if(err){
            NSLog(@"Failed to serialize into JSON: %@", err);
            return;
        }

        NSMutableArray <Genre *> *genres = NSMutableArray.new;

        for (NSDictionary *nowPlayingDict in [nowPlayingJSON valueForKey:@"genres"]) {
            NSString *name = nowPlayingDict[@"name"];
            NSNumber *id = nowPlayingDict[@"id"];

            Genre *genre = Genre.new;
            genre.name = name;
            genre.id = id;
            [genres addObject:genre];
        }

        NSLog(@"%@", genres);

        [delegate didRetrieveResponse:genres forRequest:@"MovieCategory"];
    }]
     resume];
}

@end
