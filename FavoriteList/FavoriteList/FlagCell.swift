//
//  FlagCell.swift
//  FavoriteList
//
//  Created by Аскар Кулахметов on 07.11.2026.
//

import UIKit

class FlagCell: UITableViewCell {
    
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    func configure(with item: FavoriteItem) {
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
        flagImageView.image = UIImage(named: item.imageName)
        
        let stars = [star1, star2, star3, star4, star5]
        
        for (index, star) in stars.enumerated() {
            if index < item.rating {
                star?.image = UIImage(systemName: "star.fill")
            } else {
                star?.image = UIImage(systemName: "star")
            }
        }
    }
}

