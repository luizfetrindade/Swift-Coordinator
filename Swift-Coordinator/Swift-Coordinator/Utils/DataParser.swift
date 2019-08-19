//
//  DataParser.swift
//  Swift-Coordinator
//
//  Created by Fabricio Pujol on 16/08/19.
//  Copyright © 2019 Luiz Felipe Trindade. All rights reserved.
//

import Foundation

let decoder = JSONDecoder()

struct DataParser {
    
    func nowPlayingMoviesParser(data: Data) -> Results? {
        let response = try? decoder.decode(Results.self, from: data)
        print("- - - - - - - -")
        print(response)
        return response
    }
}
