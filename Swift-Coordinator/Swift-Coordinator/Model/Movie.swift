//
//  Movie.swift
//  Swift-Coordinator
//
//  Created by Fabricio Pujol on 16/08/19.
//  Copyright © 2019 Luiz Felipe Trindade. All rights reserved.
//

import Foundation

struct Results: Codable {
    var results: [Movie]?
}

struct Movie: Codable {
    var id: Int?
    var title: String?
    var poster_path: String?
    var genre_ids: [Int]?
    var overview: String?
    var vote_avarage: Double?
}



