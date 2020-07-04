//
//  MusicAPIFactory.swift
//  MoshiTest
//
//  Created by Hayden Jamieson on 04/07/2020.
//  Copyright © 2020 Hayden Jamieson. All rights reserved.
//

import Foundation

public class MusicAPIFactory {
    
    private let urlSession = URLSession(configuration: .default)
    
    private lazy var network: NetworkProvider = {
        
        return NetworkProviderImpl(session: self.urlSession)
    }()
    
    func createSpotifyService() -> SpotifyService {
        
        let spotifyService = SpotifyServiceImpl(networkProvider: network)
        
        return spotifyService
    }
}
