//
//  File.swift
//  Swift-Coordinator
//
//  Created by Fabricio Pujol on 20/08/19.
//  Copyright © 2019 Luiz Felipe Trindade. All rights reserved.
//

import Foundation

struct PopularMoviesProvider {
    var data = Request()
    var parser = DataParser()
    
    func providePopularMoviesProvider(completitionHandler: @escaping (Results?)->Void){
        data.fetchPopularMovies { (data) in
            let movies = self.parser.nowPlayingMoviesParser(data: data!)
            completitionHandler(movies)
            //print(movies)
        }
    }
}
