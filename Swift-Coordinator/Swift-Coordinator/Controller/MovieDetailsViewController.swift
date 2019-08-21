//
//  MovieDetailsViewController.swift
//  Swift-Coordinator
//
//  Created by Fabricio Pujol on 20/08/19.
//  Copyright © 2019 Luiz Felipe Trindade. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController, Storyboarded {
    
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var overviewLabel: UITextView!
    @IBOutlet var genresLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var posterImageview: UIImageView!
    
    weak var coordinator: MainCoordinator?
    var movie = Movie()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(movie.title)
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        scoreLabel.text  = "\(movie.vote_average!)"
        
        
        let string = movie.poster_path!
        let stringUrl = "https://image.tmdb.org/t/p/w500\(string)"
        
        let posterUrl = URL(string: stringUrl)
        let data = try? Data(contentsOf: posterUrl!)
        if let imageData = data {
            posterImageview.image = UIImage(data: imageData)
        }

        // Do any additional setup after loading the view.
    }

}
