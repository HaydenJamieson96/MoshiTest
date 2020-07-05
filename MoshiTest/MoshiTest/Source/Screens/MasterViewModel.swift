//
//  MasterViewModel.swift
//  MoshiTest
//
//  Created by Hayden Jamieson on 05/07/2020.
//  Copyright © 2020 Hayden Jamieson. All rights reserved.
//

import Foundation

class MasterViewModel {
    
    var albums: Albums?
    
    func getLatestAlbumReleases() {
        
        ServiceFactory.shared().spotifyService?.getNewAlbumReleases { [weak self] (albums) in
            
            if let safeAlbums = albums {
                
                self?.albums = safeAlbums
            }
        }
    }
}
