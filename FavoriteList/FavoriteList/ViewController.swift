//
//  ViewController.swift
//  FavoriteList
//
//  Created by Аскар Кулахметов on 01.11.2026.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let flags: [FavoriteItem] = [
        FavoriteItem(title: "Египет", subtitle: "Африка", imageName: "flag_egipet_new_0", rating: 4),
        FavoriteItem(title: "Гонконг", subtitle: "Азия", imageName: "flag_gonkong_enl", rating: 5),
        FavoriteItem(title: "Германия", subtitle: "Европа", imageName: "flag_germanija_enl", rating: 5),
        FavoriteItem(title: "Бутан", subtitle: "Азия", imageName: "flag_bytan_new", rating: 3),
        FavoriteItem(title: "Бельгия", subtitle: "Европа", imageName: "flag_belgija_enl", rating: 4),
        FavoriteItem(title: "Бразилия", subtitle: "Южная Америка", imageName: "flag_brazilija_enl", rating: 5),
        FavoriteItem(title: "Буркина-Фасо", subtitle: "Африка", imageName: "flag_burkina_faso_new", rating: 3),
        FavoriteItem(title: "Босния и Герцеговина", subtitle: "Европа", imageName: "flag_bosnija_gertsegovina_new", rating: 4),
        FavoriteItem(title: "Австралия", subtitle: "Океания", imageName: "flag_avstraliya_enl", rating: 5),
        FavoriteItem(title: "Барбадос", subtitle: "Карибы", imageName: "flag_barbados_enl", rating: 4),
        FavoriteItem(title: "Бангладеш", subtitle: "Азия", imageName: "flag_bangladesh_enl", rating: 3),
        FavoriteItem(title: "Армения", subtitle: "Евразия", imageName: "flag_armeniya_new", rating: 4),
        FavoriteItem(title: "Аргентина", subtitle: "Южная Америка", imageName: "flag_argentina_enl", rating: 5),
        FavoriteItem(title: "Антигуа и Барбуда", subtitle: "Карибы", imageName: "flag_antigua_bapbuda_enl", rating: 4),
        FavoriteItem(title: "Алжир", subtitle: "Африка", imageName: "flag_algir_enl", rating: 3),
        FavoriteItem(title: "Азербайджан", subtitle: "Евразия", imageName: "flag_azerbaidzan_enl", rating: 4),
        FavoriteItem(title: "Албания", subtitle: "Европа", imageName: "flag_albaniya_enl", rating: 3),
        FavoriteItem(title: "Абхазия", subtitle: "Кавказ", imageName: "flag_abhazja_enl", rating: 2),
        FavoriteItem(title: "Россия", subtitle: "Евразия", imageName: "flag_rf_enl", rating: 4),
        FavoriteItem(title: "Англия", subtitle: "Европа", imageName: "flag_england1", rating: 5)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
}


extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FlagCell", for: indexPath) as? FlagCell else {
            return UITableViewCell()
        }
        
        let country = flags[indexPath.row]
        cell.configure(with: country)
        
        return cell
    }
}

