//
//  ServiceFactory.swift
//  MoshiTest
//
//  Created by Hayden Jamieson on 04/07/2020.
//  Copyright © 2020 Hayden Jamieson. All rights reserved.
//

import Foundation

public class ServiceFactory {
    
    var spotifyService: MusicService?
    
    private let urlSession = URLSession(configuration: .default)

    private lazy var network: NetworkProvider = {
        
        return NetworkProviderImpl(session: self.urlSession)
    }()
    
    private static var sharedServiceFactory: ServiceFactory = {
        
        let serviceFactory = ServiceFactory()

        serviceFactory.createSpotifyService()

        return serviceFactory
    }()
    
    class func shared() -> ServiceFactory {
        
        return sharedServiceFactory
    }
    
    private func createSpotifyService() {
        
        let spotifyService = SpotifyServiceImpl(networkProvider: network)
        
        self.spotifyService = spotifyService
    }
}
