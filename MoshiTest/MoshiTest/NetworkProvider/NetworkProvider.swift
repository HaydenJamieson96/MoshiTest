//
//  NetworkProvider.swift
//  MoshiTest
//
//  Created by Hayden Jamieson on 04/07/2020.
//  Copyright © 2020 Hayden Jamieson. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    
    case get = "GET"
    
    case post = "POST"
    
    case put = "PUT"
    
    case delete = "DELETE"
}

public enum NetworkResponse<T> {
    
    case success(T)
    
    case failure(NetworkError)
}

public enum NetworkError {
    
    case error(Error)
    
    case errorCode(Int)
    
    case cannotParseJSON(Int)
    
    case invalidUrl
    
    case missingRequiredData
    
    case unauthenticated
    
    case unknown
}

protocol NetworkProvider {
    
    func request<T: Decodable, R: Encodable>(url: String,
                                             method: HTTPMethod,
                                             headers: [String: String]?,
                                             body: R?,
                                             queryParameters: [String: String]?,
                                             type: T.Type,
                                             completion: @escaping (NetworkResponse<T>) -> Void)
    
    func requestWithComponents<T: Decodable>(url: String,
                                                    method: HTTPMethod,
                                                    headers: [String: String]?,
                                                    body: URLComponents?,
                                                    queryParameters: [String: String]?,
                                                    type: T.Type,
                                                    completion: @escaping (NetworkResponse<T>) -> Void)
}

protocol URLSessionProtocol {
    
    func dataRequest(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}
