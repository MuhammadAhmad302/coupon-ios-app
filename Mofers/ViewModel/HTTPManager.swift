//
//  HTTPManager.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-05-02.
//

import Foundation
import UIKit

//class HTTPManager: APIHandler {
//
//    static let shared: HTTPManager = HTTPManager()
//
//    public func get<T: Codable>(_ apiName: String , completion: @escaping (_ response: T?) -> Void) {
//
//        let url = URL(string: "\(apiName)")!
//        var request = URLRequest(url: url)
////        request.addValue("Bearer \(UserDefaults.token)", forHTTPHeaderField: "Authorization")
////        request.addValue("\(UserDefaults.deviceId)", forHTTPHeaderField: "device-Id")
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data else {
//                completion(nil)
//                return
//            }
//            do {
//                let response = try JSONDecoder().decode(T.self, from: data)
//                completion(response)
//            } catch {
//                completion(nil)
//            }
//        }
//        task.resume()
//    }
//
//    public func post<T: Codable>(_ apiName: String, withparams parameters: [String:Any] = [:], noHeaders: Bool = false, completion: @escaping (_ response: T?) -> Void) {
//
//        let url = URL(string: "\(apiName)")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
////        request.addValue("Bearer \(UserDefaults.token)", forHTTPHeaderField: "Authorization")
////        request.addValue("\(UserDefaults.deviceId)", forHTTPHeaderField: "Device-Id")
//        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        let postData = parameters.map { "\($0)=\($1)" }.joined(separator: "&").data(using: .utf8)
//        request.httpBody = postData
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data else {
//                completion(nil)
//                return
//            }
//            do {
//                let response = try JSONDecoder().decode(T.self, from: data)
//                completion(response)
//            } catch {
//                completion(nil)
//            }
//        }
//        task.resume()
//    }
//
//    public func update<T: Codable>(_ apiName: String, withparams parameters: [String:Any] = [:], noHeaders: Bool = false, completion: @escaping (_ response: T?) -> Void) {
//
//        let url = URL(string: "\(apiName)")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "PUT"
////        request.addValue("Bearer \(UserDefaults.token)", forHTTPHeaderField: "Authorization")
////        request.addValue("\(UserDefaults.deviceId)", forHTTPHeaderField: "Device-Id")
//        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        let postData = parameters.map { "\($0)=\($1)" }.joined(separator: "&").data(using: .utf8)
//        request.httpBody = postData
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data else {
//                completion(nil)
//                return
//            }
//            do {
//                let response = try JSONDecoder().decode(T.self, from: data)
//                completion(response)
//            } catch {
//                completion(nil)
//            }
//        }
//        task.resume()
//    }
//}



class HTTPManager: APIHandler {

    static let shared: HTTPManager = HTTPManager()

    private let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.httpCookieAcceptPolicy = .never
        configuration.httpCookieStorage = nil
        configuration.urlCache = nil
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        return URLSession(configuration: configuration)
    }()

    public func get<T: Codable>(_ apiName: String , completion: @escaping (_ response: T?) -> Void) {

        let url = URL(string: "\(apiName)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request) { data, response, error in
            let result: T? = self.handleResponse(data, response: response, error: error)
            completion(result)
        }
        task.resume()
    }

    public func post<T: Codable>(_ apiName: String, withparams parameters: [String:Any] = [:], noHeaders: Bool = false, completion: @escaping (_ response: T?) -> Void) {

        let url = URL(string: "\(apiName)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = jsonData

        let task = session.dataTask(with: request) { data, response, error in
            let result: T? = self.handleResponse(data, response: response, error: error)
            completion(result)
        }
        task.resume()
    }

    public func update<T: Codable>(_ apiName: String, withparams parameters: [String:Any] = [:], noHeaders: Bool = false, completion: @escaping (_ response: T?) -> Void) {

        let url = URL(string: "\(apiName)")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = jsonData

        let task = session.dataTask(with: request) { data, response, error in
            let result: T? = self.handleResponse(data, response: response, error: error)
            completion(result)
        }
        task.resume()
    }
}

