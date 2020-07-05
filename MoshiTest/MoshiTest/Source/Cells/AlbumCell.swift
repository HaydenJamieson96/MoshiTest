//
//  AlbumCell.swift
//  MoshiTest
//
//  Created by Hayden Jamieson on 05/07/2020.
//  Copyright © 2020 Hayden Jamieson. All rights reserved.
//

import UIKit
import SDWebImage

class AlbumCell: UICollectionViewCell {
    
    @IBOutlet weak var albumImage: UIImageView!
    
    @IBOutlet weak var albumNameLbl: UILabel!
    
    @IBOutlet weak var aldbumReleaseDateLbl: UILabel!
    
    @IBOutlet weak var shareBtn: UIButton!
    
    private var album: Item?
    
    func configure(with album: Item) {
        
        self.album = album
        
        albumImage.sd_imageTransition = .fade
        
        let imageUrl = URL(string: album.images.first?.url ?? "")
        
        albumImage.sd_setImage(with: imageUrl,
                               placeholderImage: nil,
                               options: SDWebImageOptions(arrayLiteral: .forceTransition))
        
        albumNameLbl.text = album.name
        
        aldbumReleaseDateLbl.text = album.releaseDate
    }
    
    @IBAction func didTapShareBtn(_ sender: Any) {
    
        
    }
}
