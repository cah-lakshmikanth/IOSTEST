//
//  CatImageResponse.swift
//  iOSPoc
//
//  Created by Lakshmikanth on 02/10/23.
//

import Foundation
struct CatImageResponse: Codable {
    var id: String
    var url: String
    var width: Int
    var height: Int
}
