//
//  LoginModel.swift
//  toBanto
//
//  Created by mora hakim on 07/11/21.
//

import Foundation

struct LoginModel: Codable {
    let username: String
    let password: String
    let grant_type: String
    let client_id: String
    let client_secret: String
}


struct LoginResponseModel: Codable {
    var access_token: String
    var token_type: String
    var refresh_token: String
    var expires_in: Int
    var scope: String
}
