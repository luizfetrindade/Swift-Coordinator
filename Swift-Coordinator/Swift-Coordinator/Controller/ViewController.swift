//
//  ViewController.swift
//  Swift-Coordinator
//
//  Created by Luiz Felipe Trindade on 16/08/19.
//  Copyright © 2019 Luiz Felipe Trindade. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let movieProvider = NowPlayingMoviesProvider()
    var movies = Results()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieProvider.provideNowPlayingMoviesProvider { [weak self] (movies) in
            guard let strongSelf = self, let movies = movies else {return}
            strongSelf.movies = movies
            print(movies)
        }
        // Do any additional setup after loading the view.
    }
}

