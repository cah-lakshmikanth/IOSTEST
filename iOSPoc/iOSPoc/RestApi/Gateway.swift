//
//  Gateway.swift
//  iOSPoc
//
//  Created by Lakshmikanth on 02/10/23.
//

import Foundation
typealias GatewayCompletion = (_ response: Data?, _ error: Error?) -> Void
protocol Gateway {
    func setHeader(key: String!, value: String?)
    func REQUEST(_ type: String, _ slug: String, parameters: [String: Any]?, completion:@escaping GatewayCompletion)
}
