//
//  toBantoTesting.swift
//  toBantoTests
//
//  Created by mora hakim on 16/12/21.
//

import XCTest
@testable import toBanto

class toBantoTesting: XCTestCase {
    
    func testLoginValidationWithEmptyString() {
        let validation = LoginValidation()
        let request = LoginModel(username: "", password: "", grant_type: "password", client_id: "my-client-apps", client_secret: "password")
        
        // ACT
        let result = validation.validate(request: request)
        
        // ASSERT
        XCTAssertFalse(result.isValid)
        XCTAssertNotNil(result.message)
        XCTAssertEqual(result.message, "email or password cannot be empty")
    }
    
    func test_LoginValidation_With_EmptyEmail_Returns_ValidationFailure(){
        
        // ARRANGE
        let validation = LoginValidation()
        let request = LoginModel(username: "", password: "test", grant_type: "password", client_id: "my-client-apps", client_secret: "password")
        
        // ACT
        let result = validation.validate(request: request)
        
        // ASSERT
        XCTAssertFalse(result.isValid)
        XCTAssertNotNil(result.message)
        XCTAssertEqual(result.message, "email or password cannot be empty")
        
    }
    
    func test_LoginValidation_With_EmptyPassword_Returns_ValidationFailure(){
        
        // ARRANGE
        let validation = LoginValidation()
        let request = LoginModel(username: "test", password: "", grant_type: "password", client_id: "my-client-apps", client_secret: "password")
        
        // ACT
        let result = validation.validate(request: request)
        
        // ASSERT
        XCTAssertFalse(result.isValid)
        XCTAssertNotNil(result.message)
        XCTAssertEqual(result.message, "email or password cannot be empty")
        
    }
    
    func test_LoginValidation_With_InvalidEmailId_Returns_ValidationFailure(){
        
        // ARRANGE
        let validation = LoginValidation()
        let request = LoginModel(username: "test", password: "test", grant_type: "password", client_id: "my-client-apps", client_secret: "password")
        
        // ACT
        let result = validation.validate(request: request)
        
        // ASSERT
        XCTAssertFalse(result.isValid)
        XCTAssertNotNil(result.message)
        XCTAssertEqual(result.message, "email id is invalid")
    }
    
    func test_LoginValidation_With_ValidRequest_Returns_Success(){
        
        // ARRANGE
        let validation = LoginValidation()
        let request = LoginModel(username: "hakim12@gmail.com", password: "test", grant_type: "password", client_id: "my-client-apps", client_secret: "password")
        
        // ACT
        let result = validation.validate(request: request)
        
        // ASSERT
        XCTAssertTrue(result.isValid)
        XCTAssertNil(result.message)
    }
    
}
