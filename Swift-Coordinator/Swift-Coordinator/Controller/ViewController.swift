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
    
    weak var coordinator: MainCoordinator?
    
    let movieProvider = NowPlayingMoviesProvider()
    var movies = Results()
    
    let popularMoviesProvider = PopularMoviesProvider()
    var popularMovies = Results()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieProvider.provideNowPlayingMoviesProvider { [weak self] (movies) in
            guard let strongSelf = self, let movies = movies else {return}
            strongSelf.movies = movies
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
        
        //        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        self.mainTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    
    @IBAction func detailTapped(_ sender: Any) {
        coordinator?.goToMovieDetails()
    }
    
    
    @IBAction func nowPlayingTapped(_ sender: Any) {
        coordinator?.goToNowPlaying()
    }
    
}

extension ViewController: UITableViewDataSource {
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
