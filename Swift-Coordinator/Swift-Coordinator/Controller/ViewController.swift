//
//  ViewController.swift
//  Swift-Coordinator
//
//  Created by Luiz Felipe Trindade on 16/08/19.
//  Copyright © 2019 Luiz Felipe Trindade. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Storyboarded {
    
    weak var coordinator: MainCoordinator?
    
    let movieProvider = NowPlayingMoviesProvider()
    var movies = Results()
    
    let popularMoviesProvider = PopularMoviesProvider()
    var popularMovies = Results()
    
    let genreProvider = GenreProvider()
    var genreOfMovies = Genres()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieProvider.provideNowPlayingMoviesProvider { [weak self] (movies) in
            guard let strongSelf = self, let movies = movies else {return}
            strongSelf.movies = movies
            print(movies)
        }
        
        popularMoviesProvider.providePopularMoviesProvider {[weak self] (popularMovies) in
            guard let strongSelf = self, let popularMovies = popularMovies else {return}
            strongSelf.popularMovies = popularMovies
            print(popularMovies)
        }
        
        genreProvider.genreProvider {[weak self] (genreOfMovies) in
            guard let strongSelf = self, let genreOfMovies = genreOfMovies else {return}
            strongSelf.genreOfMovies = genreOfMovies
            print(genreOfMovies)
        }
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func detailTapped(_ sender: Any) {
        coordinator?.goToMovieDetails()
    }
    
    
    @IBAction func nowPlayingTapped(_ sender: Any) {
        coordinator?.goToNowPlaying()
    }
    
}

