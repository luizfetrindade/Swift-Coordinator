//
//  NowPlayingViewController.swift
//  Swift-Coordinator
//
//  Created by Fabricio Pujol on 20/08/19.
//  Copyright © 2019 Luiz Felipe Trindade. All rights reserved.
//

import UIKit

class NowPlayingViewController: UIViewController, Storyboarded {

    weak var coordinator: MainCoordinator?
    var movies: [Movie]?
    
    @IBOutlet weak var numberOfResults: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let nibCollectionName = UINib(nibName: "ReleaseCollectionViewCell", bundle: nil)
        collectionView.register(nibCollectionName, forCellWithReuseIdentifier: "ReleaseCollectionViewCell")
        
        self.collectionView.dataSource = self
        
    }

}


extension NowPlayingViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let movies = movies else { return 0 }
        numberOfResults.text = "Showing \(String(movies.count)) results"
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReleaseCollectionViewCell", for: indexPath) as! ReleaseCollectionViewCell
        if let movies = movies, let posterPath = movies[indexPath.row].poster_path, let title = movies[indexPath.row].title, let score = movies[indexPath.row].vote_average {
            
            let stringUrl = "https://image.tmdb.org/t/p/w500\(posterPath)"
            
            let posterUrl = URL(string: stringUrl)
            let data = try? Data(contentsOf: posterUrl!)
            if let imageData = data {
                cell.poster.image = UIImage(data: imageData)
            }
    
            cell.title.text = title
            cell.score.text = String(score)
            
            
        }
        
        return cell

    }
    
}
