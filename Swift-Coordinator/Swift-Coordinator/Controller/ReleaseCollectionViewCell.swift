//
//  ReleaseCollectionViewCell.swift
//  Swift-Coordinator
//
//  Created by Luiz Felipe Trindade on 20/08/19.
//  Copyright © 2019 Luiz Felipe Trindade. All rights reserved.
//

import UIKit

class ReleaseCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var score: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        poster.layer.cornerRadius = 10
    }
    
    func commonInit(title: String, description: String, score: Float, poster: String){
        self.title.text = title
        self.score.text = "\(score)"
        
        let posterUrl = URL(fileURLWithPath: poster)
        let data = try? Data(contentsOf: posterUrl)
        if let imageData = data {
            self.poster.image = UIImage(data: imageData)
        }
    }

}
