//
//  APIHandler.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-05-02.
//

import Foundation

//class APIHandler {
//
//    var statusCode = Int.zero
//
//    func handleResponse<T: Codable>(_ data: Data?, response: URLResponse?, error: Error?) -> Any? {
//        guard let data = data, error == nil else {
//            return nil
//        }
//
//        if let httpResponse = response as? HTTPURLResponse {
//            self.statusCode = httpResponse.statusCode
//        }
//
//        do {
//            let response = try JSONDecoder().decode(T.self, from: data)
//            return response
//        } catch {
//            return nil
//        }
//    }
//}


class APIHandler {

    var statusCode = Int.zero

    func handleResponse<T: Codable>(_ data: Data?, response: URLResponse?, error: Error?) -> T? {
        guard let data = data else {
            return nil
        }
        do {
            let response = try JSONDecoder().decode(T.self, from: data)
            return response
        } catch {
            return nil
        }
    }
}

