//
//  SpotifyServiceImpl.swift
//  MoshiTest
//
//  Created by Hayden Jamieson on 04/07/2020.
//  Copyright © 2020 Hayden Jamieson. All rights reserved.
//

import Foundation
import UIKit

struct SpotifyAuthResponse: Codable {
    
    let accessToken: String
    
    let tokenType: String
    
    let expiresIn: Int
    
    enum CodingKeys: String, CodingKey {
        
        case accessToken = "access_token"
        
        case tokenType = "token_type"
        
        case expiresIn = "expires_in"
    }
}

struct EmptyBody: Codable {
    
    func create() -> String? {
        
        return nil
    }
}

class SpotifyServiceImpl: MusicService {
    
    let networkProvider: NetworkProvider
    
    init(networkProvider: NetworkProvider) {
        
        self.networkProvider = networkProvider
    }

    func requestAuthorisation(_ completion: @escaping (_ token: String?) -> Void) {
        
        let url = "https://accounts.spotify.com/api/token"
        
        let clientId = "0c17bd400a1d40f9a7c110b2124de974"
        
        let clientSecret = "4d1c1eac43fe4337b417b6ae8e8a4d55"
        
        let encoded = "Basic \((clientId + ":" + clientSecret).data(using: .utf8)!.base64EncodedString())"
        
        var requestBodyComponents = URLComponents()
        
        requestBodyComponents.queryItems = [URLQueryItem(name: "grant_type", value: "client_credentials")]
        
        let requestHeaders = [
            "Authorization": encoded,
            "Content-Type" : "application/x-www-form-urlencoded"
        ]
        
        networkProvider.requestWithComponents(url: url, method: .post, headers: requestHeaders, body: requestBodyComponents, queryParameters: nil, type: SpotifyAuthResponse.self) { (response) in
            
            switch response {
            
            case .success(let responseObject):
                completion(responseObject.accessToken)
                
            case .failure(_):
                print(response)
                completion(nil)
            }
        }
    }
    
    func getNewAlbumReleases(_ completion: @escaping (_ albums: Albums?) -> Void) {
        
        let url = "https://api.spotify.com/v1/browse/new-releases"
        
        requestAuthorisation { [weak self] (token) in

            if let safeToken = token {
                
                let authHeader = [
                    "Authorization": "Bearer \(safeToken)"
                ]
                
                self?.networkProvider.request(url: url, method: .get, headers: authHeader, body: EmptyBody().create(), queryParameters: nil, type: AlbumRootObject.self) { (response) in
                    
                    switch response {
                        
                    case .success(let responseObject):
                        completion(responseObject.albums)
                        
                    case .failure(_):
                        completion(nil)
                    }
                }

                print(safeToken)
            }
        }
    }
}
