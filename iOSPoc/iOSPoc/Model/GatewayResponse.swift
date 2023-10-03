//
//  GatewayResponse.swift
//  iOSPoc
//
//  Created by Lakshmikanth on 02/10/23.
//

import Foundation
class GatewayResponse<T: Codable>: Codable {
    var data: T?
}
class GatewayArrayResponse<T: Codable>: Codable {
    var data: [T]?
}
