//
//  URLRequest+Extension.swift
//  MoshiTest
//
//  Created by Hayden Jamieson on 04/07/2020.
//  Copyright © 2020 Hayden Jamieson. All rights reserved.
//

import Foundation

extension URLRequest {
    
    mutating func setHTTPMethod(_ method: HTTPMethod) {
        
        self.httpMethod = method.rawValue
    }
    
    mutating func setHeaders(_ headers: [String: String]) {
        
        headers.forEach { addValue($0.value, forHTTPHeaderField: $0.key) }
    }
    
    mutating func setBody<T: Encodable>(_ body: T) {
        
        self.httpBody = try? JSONEncoder().encode(body)
    }
}
