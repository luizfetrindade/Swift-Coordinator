//
//  Request.swift
//  Swift-Coordinator
//
//  Created by Fabricio Pujol on 16/08/19.
//  Copyright © 2019 Luiz Felipe Trindade. All rights reserved.
//

import Foundation

struct Request {
    let resourceURL: URL
    let apiKey = "ec133e4315b807c11f344060f8b97991"
    let region = "BR"
    
    init() {

        let resourceString = "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)&language=en-US&region=\(region)"
        guard let resourceURL = URL(string: resourceString) else {fatalError("invalid UrlPath")}
        
        print(resourceString)
        self.resourceURL = resourceURL
    }
    
    func fetchMovies(completitionHandler: @escaping (Data?) -> Void){
        let session = URLSession.shared
        
        let task = session.dataTask(with: resourceURL) { (data,response, error) in
            
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












//struct HolidayRequest {
//
//    func getHolidays (completion: @escaping(Result<[HolidayDetail], HolidayError>) -> Void){
//        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
//            guard let jsonData = data else {
//                completion(.failure(.noDataAvailable))
//                return
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                let holidaysResponse = try decoder.decode(HolidayResponse.self, from: jsonData)
//                let holidayDetails = holidaysResponse.response.holidays
//                completion(.success(holidayDetails))
//            } catch {
//                completion(.failure(.canNotProcessData))
//            }
//        }
//        dataTask.resume()
//    }
//}
