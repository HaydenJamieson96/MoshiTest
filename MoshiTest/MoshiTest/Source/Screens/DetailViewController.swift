//
//  DetailViewController.swift
//  MoshiTest
//
//  Created by Hayden Jamieson on 05/07/2020.
//  Copyright © 2020 Hayden Jamieson. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    @IBOutlet weak var albumImage: UIImageView!
    
    @IBOutlet weak var artistNamesLbl: UILabel!
    
    @IBOutlet weak var albumNameLbl: UILabel!
    
    @IBOutlet weak var releaseDateLbl: UILabel!
    
    @IBOutlet weak var trackCountLbl: UILabel!
    
    @IBOutlet weak var albumType: UILabel!
    
    var album: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        
        setUI()
    }
    
    func setUI() {
        
        guard let safeAlbum = album else { return }
        
        let imageUrl = URL(string: safeAlbum.images.first?.url ?? "")
        
        albumImage.sd_setImage(with: imageUrl,
                               placeholderImage: nil,
                               options: SDWebImageOptions(arrayLiteral: .forceTransition))
        
        let artistsNames = safeAlbum.artists.map({ $0.name })
        
        artistNamesLbl.text = artistsNames.joined(separator: ", ")
        
        albumNameLbl.text = safeAlbum.name
        
        releaseDateLbl.text = safeAlbum.releaseDate
        
        trackCountLbl.text = "\(safeAlbum.totalTracks) tracks"
        
        albumType.text = safeAlbum.albumType.rawValue
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .white
    }
}
