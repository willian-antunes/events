//
//  Network.swift
//  Events
//
//  Created by Willian Antunes on 29/12/19.
//  Copyright © 2019 Willian Antunes. All rights reserved.
//

import Foundation

typealias NetworkCompletionHandler = (Data?, URLResponse?, Error?) -> Void
typealias ErrorHandler = (String) -> Void

class Network {
    static let genericError = "Something went wrong. Please try again later"
    func get<T: Decodable>(urlString: String,
                           headers: [String: String] = [:],
                           successHandler: @escaping (T) -> Void,
                           errorHandler: @escaping ErrorHandler) {
        
        let completionHandler: NetworkCompletionHandler = { (data, urlResponse, error) in
            if let error = error {
                print(error.localizedDescription)
                errorHandler(Network.genericError)
                return
            }
            
            if self.isSuccessCode(urlResponse) {
                guard let data = data else {
                    print("Unable to parse the response in given type \(T.self)")
                    return errorHandler(Network.genericError)
                }
                if T.self == Data.self {
                    successHandler(data as! T)
                    return
                } else {
                    if let responseObject = try? JSONDecoder().decode(T.self, from: data) {
                        successHandler(responseObject)
                        return
                    }
                }
            }
            errorHandler(Network.genericError)
        }
        
        guard let url = URL(string: urlString) else {
            return errorHandler("Unable to create URL from given string")
        }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        URLSession.shared.dataTask(with: request,
                                   completionHandler: completionHandler)
            .resume()
    }
    
    private func isSuccessCode(_ statusCode: Int) -> Bool {
        return statusCode >= 200 && statusCode < 300
    }
    
    private func isSuccessCode(_ response: URLResponse?) -> Bool {
        guard let urlResponse = response as? HTTPURLResponse else {
            return false
        }
        return isSuccessCode(urlResponse.statusCode)
    }

    func post<T: Encodable>(urlString: String,
                            body: T,
                            headers: [String: String] = [:],
                            errorHandler: @escaping ErrorHandler) {
            let completionHandler: NetworkCompletionHandler = { (data, urlResponse, error) in
                if let error = error {
                    print(error.localizedDescription)
                    errorHandler(Network.genericError)
                    return
                }
                if !self.isSuccessCode(urlResponse) {
                    errorHandler(Network.genericError)
                    return
                }
            }
            guard let url = URL(string: urlString) else {
                return errorHandler("Unable to create URL from given string")
            }
            var request = URLRequest(url: url)
            request.timeoutInterval = 90
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = headers
            request.allHTTPHeaderFields?["Content-Type"] = "application/json"
            guard let data = try? JSONEncoder().encode(body) else {
                return errorHandler("Cannot encode given object into Data")
            }
            request.httpBody = data
            URLSession.shared
                .uploadTask(with: request,
                            from: data,
                            completionHandler: completionHandler)
                .resume()
        }
}
