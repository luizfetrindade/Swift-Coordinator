//
//  GenreProvider.swift
//  Swift-Coordinator
//
//  Created by Fabricio Pujol on 20/08/19.
//  Copyright © 2019 Luiz Felipe Trindade. All rights reserved.
//

import Foundation

struct GenreProvider {
    var data = Request()
    var parser = DataParser()
    
    func genreProvider(completitionHandler: @escaping (Genres?)->Void){
        data.fetchGenre { (data) in
            let genres = self.parser.genreMoviesParser(data: data!)
            completitionHandler(genres)
        }
    }
}
