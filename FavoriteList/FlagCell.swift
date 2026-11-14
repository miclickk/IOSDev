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

    func configure(with item: FavoriteItem) {
        titleLabel.text = item.title
        flagImageView.image = UIImage(named: item.imageName)
    }
}
