//
//  PopularMorivesTableViewCell.swift
//  Swift-Coordinator
//
//  Created by Luiz Felipe Trindade on 20/08/19.
//  Copyright © 2019 Luiz Felipe Trindade. All rights reserved.
//

import UIKit

class PopularMoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImageView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupXib() {
        Bundle.main.loadNibNamed("PopularMoviesTableViewCell", owner: self, options: nil)
    }
    
    func commonInit(title: String, description: String, score: Float, poster: String){
        titleLabel.text = title
        descriptionLabel.text = description
        scoreLabel.text = description
        
        let posterUrl = URL(fileURLWithPath: poster)
        let data = try? Data(contentsOf: posterUrl)
        if let imageData = data {
            posterImageView.image = UIImage(data: imageData)
        }
    }
}
