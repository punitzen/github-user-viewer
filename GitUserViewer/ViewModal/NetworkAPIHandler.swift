//
//  NetworkAPIHandler.swift
//  GitUserViewer
//
//  Created by Punit Kumar on 17/08/22.
//

import Foundation

class NetworkAPIHandler {
    static func APIContract(_ url: String, _ completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            completionHandler(data, response, error)
        }
        task.resume()
    }
}
