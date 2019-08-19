//
//  NowPlayingMoviesProvider.swift
//  Swift-Coordinator
//
//  Created by Fabricio Pujol on 16/08/19.
//  Copyright © 2019 Luiz Felipe Trindade. All rights reserved.
//

import Foundation

struct NowPlayingMoviesProvider {
    var data = Request()
    var parser = DataParser()
    
    func provideNowPlayingMoviesProvider(completitionHandler: @escaping (Results?)->Void){
        data.fetchMovies { (data) in
            let movies = self.parser.nowPlayingMoviesParser(data: data!)
            completitionHandler(movies)
            //print(movies)
        }
    }
}
