//
//  URLSession+Extension.swift
//  MoshiTest
//
//  Created by Hayden Jamieson on 04/07/2020.
//  Copyright © 2020 Hayden Jamieson. All rights reserved.
//

import Foundation

extension URLSession: URLSessionProtocol {
    
    @objc func dataRequest(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        return self.dataTask(with: request, completionHandler: completionHandler)
    }
}
