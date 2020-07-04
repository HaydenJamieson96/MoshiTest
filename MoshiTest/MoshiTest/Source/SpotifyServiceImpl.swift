//
//  SpotifyServiceImpl.swift
//  MoshiTest
//
//  Created by Hayden Jamieson on 04/07/2020.
//  Copyright © 2020 Hayden Jamieson. All rights reserved.
//

import Foundation

class SpotifyServiceImpl: SpotifyService {
    
    let networkProvider: NetworkProvider
    
    init(networkProvider: NetworkProvider) {
        
        self.networkProvider = networkProvider
    }
    
    func getNewAlbumReleases() {
        
        // Call network layer
    }
}
