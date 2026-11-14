//
//  DetailViewController.swift
//  FavoriteList
//
//  Created by Аскар Кулахметов on 11.11.2026.
//


import UIKit

class DetailViewController: UIViewController {
    
    var item: FavoriteItem?
    
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = item?.title
        navigationItem.largeTitleDisplayMode = .never
        
        
        if let currentItem = item {
            titleLabel.text = currentItem.title
            subtitleLabel.text = currentItem.subtitle
            descriptionLabel.text = currentItem.description
            flagImageView.image = UIImage(named: currentItem.imageName)
            
            let stars = [star1, star2, star3, star4, star5]
            for (index, star) in stars.enumerated() {
                if index < currentItem.rating {
                    star?.image = UIImage(systemName: "star.fill")
                } else {
                    star?.image = UIImage(systemName: "star")
                }
            }
        }
    }
}
