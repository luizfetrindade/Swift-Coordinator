//
//  Request.swift
//  Swift-Coordinator
//
//  Created by Fabricio Pujol on 16/08/19.
//  Copyright © 2019 Luiz Felipe Trindade. All rights reserved.
//

import Foundation

struct Request {
    let resourceURLNowPlaying: URL
    let resourceURLPopular: URL
    let resourceURLGenre: URL
    let apiKey = "ec133e4315b807c11f344060f8b97991"
    let region = "BR"
    
    init() {

        let resourceStringNowPlaying = "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)&language=en-US&region=\(region)"
        guard let resourceURLNowPlaying = URL(string: resourceStringNowPlaying) else {fatalError("invalid UrlPath")}
        
        let resourceStringPopular = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=en-US&page=1&region=\(region)"
        guard let resourceURLPopular = URL(string: resourceStringPopular) else {fatalError("invalid UrlPath")}
        
        let resourceStringGenre = "https://api.themoviedb.org/3/genre/movie/list?api_key=\(apiKey)&language=en-US"
        guard let resourceURLGenre = URL(string: resourceStringGenre) else {fatalError("invalid UrlPath")}
        
        print(resourceStringNowPlaying)
        print(resourceURLPopular)
        
        self.resourceURLNowPlaying = resourceURLNowPlaying
        self.resourceURLPopular = resourceURLPopular
        self.resourceURLGenre = resourceURLGenre
    }
    
    func fetchMovies(completitionHandler: @escaping (Data?) -> Void){
        let session = URLSession.shared
        
        let task = session.dataTask(with: resourceURLNowPlaying) { (data,response, error) in
            
            if let _ = error {
                completitionHandler(nil)
            } else {
                if let data = data {
                    completitionHandler(data)
                } else {
                    completitionHandler(nil)
                }
            }
        }
        task.resume()
    }
    
    func fetchPopularMovies(completitionHandler: @escaping (Data?) -> Void){
        let session = URLSession.shared
        
        let task = session.dataTask(with: resourceURLPopular) { (data,response, error) in
            
            if let _ = error {
                completitionHandler(nil)
            } else {
                if let data = data {
                    completitionHandler(data)
                } else {
                    completitionHandler(nil)
                }
            }
        }
        task.resume()
    }
    
    func fetchGenre(completitionHandler: @escaping (Data?) -> Void){
        let session = URLSession.shared
        let task = session.dataTask(with: resourceURLGenre) { (data,response, error) in
            
            if let _ = error {
                completitionHandler(nil)
            } else {
                if let data = data {
                    completitionHandler(data)
                } else {
                    completitionHandler(nil)
                }
            }
        }
        task.resume()
    }
}
