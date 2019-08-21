//
//  MainCoordinator.swift
//  Swift-Coordinator
//
//  Created by Fabricio Pujol on 20/08/19.
//  Copyright © 2019 Luiz Felipe Trindade. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func goToMovieDetails(to movieSelected: Movie){
        let vc = MovieDetailsViewController.instantiate()
        vc.movie = movieSelected
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func goToNowPlaying(){
        let vc = NowPlayingViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
}
