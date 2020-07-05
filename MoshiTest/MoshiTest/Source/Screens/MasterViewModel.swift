//
//  MasterViewModel.swift
//  MoshiTest
//
//  Created by Hayden Jamieson on 05/07/2020.
//  Copyright © 2020 Hayden Jamieson. All rights reserved.
//

import Foundation

class MasterViewModel {
    
    func getLatestAlbumReleases(_ completion: @escaping (_ albums: [Item]?) -> Void) {
        
        ServiceFactory.shared().spotifyService?.getNewAlbumReleases { (albums) in
            
            if let safeAlbums = albums {
                
                completion(safeAlbums.items)
                
            } else {
                
                completion([])
            }
        }
    }
}
