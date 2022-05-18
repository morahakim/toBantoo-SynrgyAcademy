//
//  ApiManager.swift
//  toBanto
//
//  Created by mora hakim on 04/11/21.
//

import Foundation
import Alamofire

enum ApiError: Error {
    case custom(message: String)
}

typealias Handler = (Swift.Result<Any?, ApiError>) -> Void


class ApiManager {
    static let shareInstance = ApiManager()
    
    func callingRegisterApi(register: RegisterModel, completionHandler: @escaping (Bool) -> ()) {
        let headers: HTTPHeaders = [
            .contentType("application/json")
        ]
        
        AF.request(registerUrl, method: .post, parameters: register, encoder: JSONParameterEncoder.default, headers: headers).response{ response in
            debugPrint(response)
            switch response.result {
            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    if response.response?.statusCode == 200 {
                        completionHandler(true)
                    }else{
                        completionHandler(false)
                    }
                }catch {
                    print(error.localizedDescription)
                    completionHandler(false)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completionHandler(false)
            }
        }
    }
    
    func callingLoginApi(login: LoginModel, completionHandler: @escaping Handler) {
        let requestHeaders : [String:String] = ["Content-type": "application/x-www-form-urlencoded"]
        var requestBodyComponent = URLComponents()
        requestBodyComponent.queryItems = [URLQueryItem(name: "grant_type", value: "password"),
                                           URLQueryItem(name: "client_id", value: "my-client-apps"),
                                           URLQueryItem(name: "client_secret", value: "password"),
                                           URLQueryItem(name: "username", value: login.username),
                                           URLQueryItem(name: "password", value: login.password)]
        var request = URLRequest(url: URL(string: "https://enigmatic-wave-05196.herokuapp.com/oauth/token")!)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = requestHeaders
        request.httpBody = requestBodyComponent.query?.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                print(data == nil)
                if error != nil {
                    print(error?.localizedDescription)
                    return
                }else {
                    if let httpResponse = response as? HTTPURLResponse {
                        print("url response: \(httpResponse.statusCode)")
                        if httpResponse.statusCode == 200 {
                            var decoder = JSONDecoder()
                            do {
                                if let jsonString = String(data: data!, encoding: .utf8) {
                                    print(jsonString)
                                    completionHandler(.success(data))
                                }
                            }catch {
                                print(error.localizedDescription)
                            }
                        }
                    }
                }
            }
            
        }.resume()
    }
    
    func callingForgotApi(forgot: ForgotPasswordModel, completionHandler: @escaping (Bool) -> ()) {
        let headers: HTTPHeaders = [
            .contentType("application/json")
        ]
        
        AF.request(forgotUrl, method: .post, parameters: forgot, encoder: JSONParameterEncoder.default, headers: headers).response{ response in
            debugPrint(response)
            switch response.result {
            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    if response.response?.statusCode == 200 {
                        completionHandler(true)
                    }else{
                        completionHandler(false)
                    }
                }catch {
                    print(error.localizedDescription)
                    completionHandler(false)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completionHandler(false)
            }
        }
    }
    
    func callingOtp(otp: OtpModel, completionHandler: @escaping (Bool) -> ()) {
        let headers: HTTPHeaders = [
            .contentType("application/json")
        ]
        
        AF.request(otpUrl, method: .post, parameters: otp, encoder: JSONParameterEncoder.default, headers: headers).response{ response in
            debugPrint(response)
            switch response.result {
            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    if response.response?.statusCode == 200 {
                        completionHandler(true)
                    }else{
                        completionHandler(false)
                    }
                }catch {
                    print(error.localizedDescription)
                    completionHandler(false)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completionHandler(false)
            }
        }
    }
    
    func callingChangePw(changePw: ChangePwModel, completionHandler: @escaping (Bool) -> ()) {
        let headers: HTTPHeaders = [
            .contentType("application/json")
        ]
        
        AF.request(changePwUrl, method: .post, parameters: changePw, encoder: JSONParameterEncoder.default, headers: headers).response{ response in
            debugPrint(response)
            switch response.result {
            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    if response.response?.statusCode == 200 {
                        completionHandler(true)
                    }else{
                        completionHandler(false)
                    }
                }catch {
                    print(error.localizedDescription)
                    completionHandler(false)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completionHandler(false)
            }
        }
    }
    
    func callingUpdatePw(updatePw: UpdatePwModel, completionHandler: @escaping (Bool) -> ()) {
        var token : String
        token = UserDefaults.standard.string(forKey: "access_token") ?? "Unknow User"
        let headers: HTTPHeaders = [
            .contentType("application/json"),
            .authorization("bearer\(token)")
        ]
        
        AF.request(updatePwUrl, method: .put, parameters: updatePw, encoder: JSONParameterEncoder.default, headers: headers).response{ response in
            debugPrint(response)
            switch response.result {
            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    if response.response?.statusCode == 200 {
                        completionHandler(true)
                    }else{
                        completionHandler(false)
                    }
                }catch {
                    print(error.localizedDescription)
                    completionHandler(false)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completionHandler(false)
            }
        }
    }
    
    func callingGetCreateCampaign(completionHandler: @escaping (GetCampaignHome?) -> ()) {
        var token : String
        token = UserDefaults.standard.string(forKey: "access_token") ?? "Unknow User"
        let headers: HTTPHeaders = [
            .contentType("application/json"),
            .authorization("bearer \(token)")
        ]
        
        AF.request(getCampaignUrl,headers: headers)
            .validate()
            .responseDecodable(of: GetCampaignHome.self) { (response) in
                debugPrint(response)
                switch response.result {
                case .success(let data):
                    do {
                        data
                        if response.response?.statusCode == 200 {
                            completionHandler(data)
                        }else{
                            completionHandler(nil)
                        }
                    }catch {
                        print(error.localizedDescription)
                        completionHandler(nil)
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                    completionHandler(nil)
                }
            }
    }
    
    func callingGetHistoryCampaign(completionHandler: @escaping (GetHistoryModel?) -> ()) {
        var token : String
        token = UserDefaults.standard.string(forKey: "access_token") ?? "Unknow User"
        let headers: HTTPHeaders = [
            .contentType("application/json"),
            .authorization("bearer \(token)")
        ]
        
        AF.request(getHistoryDonateUrl,headers: headers)
            .validate()
            .responseDecodable(of: GetHistoryModel.self) { (response) in
                debugPrint(response)
                switch response.result {
                case .success(let data):
                    do {
                        data
                        if response.response?.statusCode == 200 {
                            completionHandler(data)
                        }else{
                            completionHandler(nil)
                        }
                    }catch {
                        print(error.localizedDescription)
                        completionHandler(nil)
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                    completionHandler(nil)
                }
            }
     }
    
    func callingGetMyCampaign(completionHandler: @escaping (GetDetailModel?) -> ()) {
        var token : String
        token = UserDefaults.standard.string(forKey: "access_token") ?? "Unknow User"
        let headers: HTTPHeaders = [
            .contentType("application/json"),
            .authorization("bearer \(token)")
        ]
        
        AF.request(getMyCampaignUrl,headers: headers)
            .validate()
            .responseDecodable(of: GetDetailModel.self) { (response) in
                debugPrint(response)
                switch response.result {
                case .success(let data):
                    do {
                        data
                        if response.response?.statusCode == 200 {
                            completionHandler(data)
                        }else{
                            completionHandler(nil)
                        }
                    }catch {
                        print(error.localizedDescription)
                        completionHandler(nil)
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                    completionHandler(nil)
                }
            }
    }
    
    func callingCampaignDonatur(completionHandler: @escaping (GetDetailModel?) -> ()) {
        var token : String
        token = UserDefaults.standard.string(forKey: "access_token") ?? "Unknow User"
        let headers: HTTPHeaders = [
            .contentType("application/json"),
            .authorization("bearer \(token)")
        ]
        
        AF.request(getCampaignDonaturUrl,headers: headers)
            .validate()
            .responseDecodable(of: GetDetailModel.self) { (response) in
                debugPrint(response)
                switch response.result {
                case .success(let data):
                    do {
                        data
                        if response.response?.statusCode == 200 {
                            completionHandler(data)
                        }else{
                            completionHandler(nil)
                        }
                    }catch {
                        print(error.localizedDescription)
                        completionHandler(nil)
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                    completionHandler(nil)
                }
            }
    }
    
    func callingPayment(payment: GetPaymentModel, completionHandler: @escaping (Bool) -> ()) {
        var token : String
        token = UserDefaults.standard.string(forKey: "access_token") ?? "Unknow User"
        let headers: HTTPHeaders = [
            .contentType("application/json"),
            .authorization("bearer \(token)")
        ]
        
        AF.request(getPaymentUrl, method: .post, parameters: payment, encoder: JSONParameterEncoder.default, headers: headers).response{ response in
            debugPrint(response)
            switch response.result {
            case .success(let data):
                do {
                    data
                    if response.response?.statusCode == 200 {
                        completionHandler(true)
                    }else{
                        completionHandler(false)
                    }
                }catch {
                    print(error.localizedDescription)
                    completionHandler(false)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completionHandler(false)
            }
        }
    }
    
    func callingSeacrhDonatur(text:String, completionHandler: @escaping (GetDetailModel?) -> ()) {
        var token : String
        token = UserDefaults.standard.string(forKey: "access_token") ?? "Unknow User"
        let headers: HTTPHeaders = [
            .contentType("application/json"),
            .authorization("bearer \(token)")
        ]
        
        AF.request(seachrUrl + text ,headers: headers)
            .validate()
            .responseDecodable(of: GetDetailModel.self) { (response) in
                debugPrint(response)
                switch response.result {
                case .success(let data):
                    do {
                        data
                        if response.response?.statusCode == 200 {
                            completionHandler(data)
                        }else{
                            completionHandler(nil)
                        }
                    }catch {
                        print(error.localizedDescription)
                        completionHandler(nil)
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                    completionHandler(nil)
                }
            }
    }
    
    func callingFilter(text:String, completionHandler: @escaping (GetDetailModel?) -> ()) {
        var token : String
        token = UserDefaults.standard.string(forKey: "access_token") ?? "Unknow User"
        let headers: HTTPHeaders = [
            .contentType("application/json"),
            .authorization("bearer \(token)")
        ]
        
        AF.request(filterUrl + text ,headers: headers)
            .validate()
            .responseDecodable(of: GetDetailModel.self) { (response) in
                debugPrint(response)
                switch response.result {
                case .success(let data):
                    do {
                        data
                        if response.response?.statusCode == 200 {
                            completionHandler(data)
                        }else{
                            completionHandler(nil)
                        }
                    }catch {
                        print(error.localizedDescription)
                        completionHandler(nil)
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                    completionHandler(nil)
                }
            }
    }
}

