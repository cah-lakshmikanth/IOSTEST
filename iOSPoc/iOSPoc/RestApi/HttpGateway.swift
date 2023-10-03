//
//  HttpGateway.swift
//  iOSPoc
//
//  Created by Lakshmikanth on 02/10/23.
//

import Foundation
class HttpGateway: NSObject, Gateway {
    private(set) var baseURL: String!

    private(set) var headers: [String :String] = ["Content-Type": "application/json",
                                             "Accept": "application/json"]

    func setHeader(key: String!, value: String?) {
        if let value = value {
            headers[key] = value
        } else {
            headers.removeValue(forKey: key)
        }
    }
    
    func REQUEST(_ type: String, _ slug: String, parameters: [String : Any]?, completion: @escaping GatewayCompletion) {
        var endpoint = baseURL + slug
        let urlRequest = URLRequest(url: URL(string: endpoint)!)
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, reponse, error in
            completion(data, error)
        }
        dataTask.resume()
    }
    init(_ baseURL: String) {
        super.init()
        self.baseURL = baseURL
    }
}
