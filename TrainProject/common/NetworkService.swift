//
//  NetworkService.swift
//  TrainProject
//
//  Created by Кристина Перегудова on 31.10.2021.
//

import Foundation
import Alamofire
import NotificationBannerSwift


extension NetworkService {
  func login(email: String, password: String,
              completion: @escaping ((AuthResponse) -> ())) {
    let parameters = ["email": email,
                      "password": password]
    baseRequest(url: "/auth/login", method: .post,
                parameters: parameters) { response in
      completion(response)
    }
  }
  
  func register(email: String, password: String,
              completion: @escaping ((AuthResponse) -> ())) {
    let parameters = ["email": email,
                      "password": password]
    baseRequest(url: "/auth/register", method: .post,
                parameters: parameters) { response in
      completion(response)
    }
  }
}

class NetworkService {
  
  static let baseURL = "http://45.144.179.101/scare-me/api/mobile/v1"
  func baseRequest<T: Decodable>(url: String, method: HTTPMethod,
                                 parameters: Parameters,
                                 completion: @escaping ((T) -> ())) {
    var headers: HTTPHeaders = [:]
    if let token = UserDefaults.standard.value(forKey: "token") as? String,
        !token.isEmpty {
      headers["Authorization"] = "Bearer" + token
    }
    AF.request(NetworkService.baseURL + url,
               method: method,
               parameters: parameters,
               encoding: URLEncoding.default,
               headers: headers)
      .responseData { response in
        print(response.request?.url, response.request?.headers, parameters)
        switch response.result {
        case .success(let data):
          let decoder = JSONDecoder()
          do {
            let decodedData = try decoder.decode(T.self, from: data)
            print(decodedData)
            completion(decodedData)
          } catch (let error) {
            print("catch", error.localizedDescription)
            GrowingNotificationBanner(title: error.localizedDescription,
                                      style: .danger).show()
          }
        case .failure(let error):
          print("failure", error.localizedDescription)
          GrowingNotificationBanner(title: error.localizedDescription,
                                    subtitle: error.errorDescription,
                                    style: .danger).show()
        }
      }
    
  }
}
