//
//  ViewController.swift
//  Assignment6.1
//
//  Created by Аскар Кулахметов on 21.10.2026.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    let favorites: [Favorite] = [
        Favorite(title: "Dawnbreaker", description: "Герой ближнего боя с основным атрибутом Сила, способный исцелять союзников.", imageName: "Dawnbreaker_icon"),
        Favorite(title: "Crystal Maiden", description: "Герой дальнего боя с основным атрибутом Интеллект, владеющий магией льда.", imageName: "Crystal_Maiden_icon"),
        Favorite(title: "Axe", description: "Герой ближнего боя с основным атрибутом Сила, провоцирующий врагов на атаку.", imageName: "Axe_icon"),
        Favorite(title: "Io", description: "Герой дальнего боя с основным атрибутом Сила, связывающийся с союзниками для баффов.", imageName: "Io_icon"),
        Favorite(title: "Juggernaut", description: "Герой ближнего боя с основным атрибутом Ловкость, наносящий быстрые удары мечом.", imageName: "Juggernaut_icon"),
        Favorite(title: "Pudge", description: "Герой ближнего боя с основным атрибутом Сила, притягивающий врагов хуком.", imageName: "Pudge_icon"),
        Favorite(title: "Sven", description: "Герой ближнего боя с основным атрибутом Сила, наносящий огромный урон по области.", imageName: "Sven_icon"),
        Favorite(title: "Tiny", description: "Герой ближнего боя с основным атрибутом Сила, способный бросать врагов и союзников.", imageName: "Tiny_icon"),
        Favorite(title: "Ursa", description: "Герой ближнего боя с основным атрибутом Ловкость, разрывающий врагов когтями.", imageName: "Ursa_icon"),
        Favorite(title: "Grimstroke", description: "Герой дальнего боя с основным атрибутом Интеллект, связывающий судьбы противников.", imageName: "Grimstroke_icon")
    ]
    
    var currentIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var newIndex: Int
        
        repeat {
            newIndex = Int.random(in: 0..<favorites.count)
        } while newIndex == currentIndex
        
        currentIndex = newIndex
        let selected = favorites[newIndex]
        
        titleLabel.text = selected.title
        descriptionLabel.text = selected.description
        
        if let image = UIImage(named: selected.imageName) {
            imageView.image = image
        } else {
            imageView.image = nil
        }
    }
}
