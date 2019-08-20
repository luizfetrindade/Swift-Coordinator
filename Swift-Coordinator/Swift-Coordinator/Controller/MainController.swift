//
//  mainController.swift
//  Swift-Coordinator
//
//  Created by Luiz Felipe Trindade on 20/08/19.
//  Copyright © 2019 Luiz Felipe Trindade. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var mainTableView: UITableView!
    
    let movieProvider = NowPlayingMoviesProvider()
    var movies = Results()
    
    let popularMoviesProvider = PopularMoviesProvider()
    var popularMovies = Results()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieProvider.provideNowPlayingMoviesProvider { [weak self] (movies) in
            guard let strongSelf = self, let movies = movies else {return}
            strongSelf.movies = movies
            
//            DispatchQueue.main.async {
//                strongSelf.mainCollectionView.reloadData()
//            }
        }
        
        popularMoviesProvider.providePopularMoviesProvider {[weak self] (popularMovies) in
            guard let strongSelf = self, let popularMovies = popularMovies else {return}
            strongSelf.popularMovies = popularMovies
            
            DispatchQueue.main.async {
                strongSelf.mainTableView.reloadData()
            }
        }
        
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
    }
}

extension MainViewController: UITableViewDelegate {
    
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}

extension MainViewController: UICollectionViewDelegate {
    
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}
