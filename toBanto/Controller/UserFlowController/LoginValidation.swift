//
//  LoginValidation.swift
//  toBanto
//
//  Created by mora hakim on 16/12/21.
//

import Foundation
struct LoginValidation {
    
    func validate(request: LoginModel) -> ValidationResponse {
        
        guard !request.username.isEmpty  && !request.password.isEmpty else {
            return ValidationResponse(message: "email or password cannot be empty", isValid: false)
        }
        
        guard request.username.isValidEmail() else {
            return ValidationResponse(message: "email id is invalid", isValid: false)
        }
        
        return ValidationResponse(message: nil, isValid: true)
    }
}
