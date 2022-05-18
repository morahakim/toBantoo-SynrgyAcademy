//
//  ubahPwModel.swift
//  toBanto
//
//  Created by Irianda on 22/11/21.
//

import Foundation

struct UpdatePwModel:Encodable {
    let email : String
    let oldPassword : String
    let newPassword1 : String
    let newPassword2 : String
}
