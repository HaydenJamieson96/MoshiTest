//
//  NetworkProviderImpl.swift
//  MoshiTest
//
//  Created by Hayden Jamieson on 04/07/2020.
//  Copyright © 2020 Hayden Jamieson. All rights reserved.
//

import Foundation

class NetworkProviderImpl: NetworkProvider {
    
    let session: URLSession
    
    init(session: URLSession) {
        
        self.session = session
    }
    
     func requestWithComponents<T: Decodable>(url: String,
                                                 method: HTTPMethod = .get,
                                                 headers: [String: String]? = nil,
                                                 body: URLComponents? = nil,
                                                 queryParameters: [String: String]?,
                                                 type: T.Type,
                                                 completion: @escaping (NetworkResponse<T>) -> Void) {
            
            var urlcomponents = URLComponents(string: url)
            
            urlcomponents?.addQueryParams(queryParameters)
            
            guard let finalUrl = urlcomponents?.url else { return }
            
            var request = URLRequest(url: finalUrl)
            
            print("Sending \(method.rawValue) request to \(finalUrl.absoluteString)")
            
            request.setHTTPMethod(method)
            
            let allHeaders = headers ?? [:]
            
            request.setHeaders(allHeaders)
            
            print("with headers of: \(String(describing: allHeaders))")
            
            if let body = body,
                method != HTTPMethod.get {
                
                request.httpBody = body.query?.data(using: .utf8)
                
                if let bodyDate = request.httpBody {
                    
                    print("with body of: \(String(data: bodyDate, encoding: .utf8) ?? "")")
                }
                
            }
            
            let dataRequest = self.session.dataRequest(with: request) { [weak self] (data, response, error) in
                
                self?.handle(with: response, and: error, for: data, type: type, completion: completion)
            }
            
            dataRequest.resume()
        }
    
    func request<T: Decodable, R: Encodable>(url: String,
                                             method: HTTPMethod = .get,
                                             headers: [String: String]? = nil,
                                             body: R? = nil,
                                             queryParameters: [String: String]?,
                                             type: T.Type,
                                             completion: @escaping (NetworkResponse<T>) -> Void) {
        
        var urlcomponents = URLComponents(string: url)
        
        urlcomponents?.addQueryParams(queryParameters)
        
        guard let finalUrl = urlcomponents?.url else { return }
        
        var request = URLRequest(url: finalUrl)
        
        print("Sending \(method.rawValue) request to \(finalUrl.absoluteString)")
        
        request.setHTTPMethod(method)
        
        var allHeaders: [String: String] = headers ?? [:]
        
        if T.self != String.self {

            if allHeaders["Accept"] == nil {
                allHeaders["Accept"] = "application/json"
            }

            if allHeaders["Content-Type"] == nil {
                allHeaders["Content-Type"] = "application/json"
            }
        }
        
        request.setHeaders(allHeaders)
        
        print("with headers of: \(String(describing: allHeaders))")
        
        if let body = body,
            method != HTTPMethod.get {
            
            request.setBody(body)
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            if let bodyDate = request.httpBody {
                
                print("with body of: \(String(data: bodyDate, encoding: .utf8) ?? "")")
            }
            
        }
        
        let dataRequest = self.session.dataRequest(with: request) { [weak self] (data, response, error) in
            
            self?.handle(with: response, and: error, for: data, type: type, completion: completion)
        }
        
        dataRequest.resume()
    }
    
    fileprivate func handle<T: Decodable>(with response: URLResponse?, and error: Error?, for data: Data?, type: T.Type, completion: @escaping (NetworkResponse<T>) -> Void) {
        
        if let error = error {
            
            completion(.failure(.error(error)))
            
        } else if let httpResponse = response as? HTTPURLResponse {
            
            switch httpResponse.statusCode {
                
            case 200...299:
                
                if let data = data {
                    
                    print(data)
                    
                    if T.self == String.self {
                        
                        if let result: T = String(decoding: data, as: UTF8.self) as? T {
                            
                            completion(.success(result))
                        }
                        
                    } else {
                        
                        if let model = try? JSONDecoder().decode(T.self, from: data) {
                            
                            completion(.success(model))
                            
                        } else {
                            
                            completion(.failure(.cannotParseJSON(httpResponse.statusCode)))
                        }
                    }
                    
                } else {
                    
                    completion(.failure(.cannotParseJSON(httpResponse.statusCode)))
                }
                
            default:
                
                completion(.failure(.errorCode(httpResponse.statusCode)))
            }
            
        } else {
            
            completion(.failure(.unknown))
        }
    }
}
