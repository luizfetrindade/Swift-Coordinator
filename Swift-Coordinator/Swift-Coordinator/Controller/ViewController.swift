//
//  ViewController.swift
//  Swift-Coordinator
//
//  Created by Luiz Felipe Trindade on 16/08/19.
//  Copyright © 2019 Luiz Felipe Trindade. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var releaseCollectionView: UICollectionView!
    
    weak var coordinator: MainCoordinator?
    
    let movieProvider = NowPlayingMoviesProvider()
    var nowMovies = Results()
    
    let popularMoviesProvider = PopularMoviesProvider()
    var popularMovies = Results()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieProvider.provideNowPlayingMoviesProvider { [weak self] (nowMovies) in
            guard let strongSelf = self, let nowMovies = nowMovies else {return}
            strongSelf.nowMovies = nowMovies

            DispatchQueue.main.async {
                strongSelf.releaseCollectionView.reloadData()
            }

        }

        popularMoviesProvider.providePopularMoviesProvider {[weak self] (popularMovies) in
            guard let strongSelf = self, let popularMovies = popularMovies else {return}
            strongSelf.popularMovies = popularMovies
            
            DispatchQueue.main.async {
                strongSelf.mainTableView.reloadData()
            }
        }
        
        let nibName = UINib(nibName: "PopularMoviesTableViewCell", bundle: nil)
        mainTableView.register(nibName, forCellReuseIdentifier: "PopularMoviesTableViewCell")
        
        let nibCollectionName = UINib(nibName: "ReleaseCollectionViewCell", bundle: nil)
        releaseCollectionView.register(nibCollectionName, forCellWithReuseIdentifier: "ReleaseCollectionViewCell")
        
        
        self.mainTableView.dataSource = self
        self.releaseCollectionView.dataSource = self
        self.mainTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    @IBAction func nowPlayingTapped(_ sender: Any) {
        coordinator?.goToNowPlaying()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coordinator?.goToMovieDetails(to: (nowMovies.results?[indexPath.row])!)
    }
    
}

//MARK - TableView DataSource Methods
extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.goToMovieDetails(to: (popularMovies.results?[indexPath.row])!)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rows = popularMovies.results else { return 0 }
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PopularMoviesTableViewCell", for: indexPath) as? PopularMoviesTableViewCell {
            let movies = popularMovies.results?[indexPath.row]
            cell.titleLabel.text = movies?.title
            cell.descriptionLabel.text = movies?.overview
            cell.scoreLabel.text = "\(movies!.vote_average!)"
            
            let string = movies!.poster_path!
            let stringUrl = "https://image.tmdb.org/t/p/w500\(string)"
            
            let posterUrl = URL(string: stringUrl)
            let data = try? Data(contentsOf: posterUrl!)
            if let imageData = data {
                cell.posterImageView.image = UIImage(data: imageData)
            }
            return cell
        }
        return UITableViewCell()
    }
    
}

//MARK - Collection View DataSource Methods
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let movies = nowMovies.results else { return 0 }
        
        let numberOfMovies = movies.count
        
        return numberOfMovies > 5 ? 5 : numberOfMovies
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReleaseCollectionViewCell", for: indexPath) as? ReleaseCollectionViewCell {
            let movies = nowMovies.results?[indexPath.row]
            cell.title.text = movies?.title
            cell.score.text = "\(movies!.vote_average!)"
            
            let string = movies!.poster_path!
            let stringUrl = "https://image.tmdb.org/t/p/w500\(string)"
            
            let posterUrl = URL(string: stringUrl)
            let data = try? Data(contentsOf: posterUrl!)
            if let imageData = data {
                cell.poster.image = UIImage(data: imageData)
            }
            
            return cell
        }
        return UICollectionViewCell()
    }
    
}
