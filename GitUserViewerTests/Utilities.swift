//
//  TestUtilities.swift
//  GitUserViewerTests
//
//  Created by Punit Kumar on 16/08/22.
//

import Foundation


class TestUtilities {
    static func decodeFromLocalData(fileName: String, _ completionHandler: @escaping (Data?, String?) -> Void) {
        guard let pathUrl = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            completionHandler(nil, "could not find file with name \(fileName).json")
            return
        }
        
        do{
            let url = URL(fileURLWithPath: pathUrl.path)
            let jsonData = try Data(contentsOf: url)
            completionHandler(jsonData, nil)
        } catch {
            completionHandler(nil, String(describing: error.localizedDescription))
        }
    }
}
