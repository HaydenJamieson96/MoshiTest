//
//  URLComponents+Extension.swift
//  MoshiTest
//
//  Created by Hayden Jamieson on 04/07/2020.
//  Copyright © 2020 Hayden Jamieson. All rights reserved.
//

import Foundation

extension URLComponents {
    
    mutating func addQueryParams(_ queryParams: [String: String]?) {
        
        if let queryParams = queryParams {
            
            var finalParams: [URLQueryItem] = []
            
            queryParams.forEach { finalParams.append(URLQueryItem(name: $0.key, value: $0.value)) }
            
            self.queryItems = finalParams
        }
    }
}
