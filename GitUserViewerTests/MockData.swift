//
//  MockData.swift
//  GitUserViewerTests
//
//  Created by Punit Kumar on 10/08/22.
//

import Foundation
@testable import GitUserViewer

class MockData: APIManager {
    
    func fetchUser(user: String, completionHandler: @escaping (Bool, UserModel?, String?) -> Void) {
        TestUtilities.decodeFromLocalData(fileName: user) { data, error in
            guard let data = data else {
                completionHandler(false, nil, String(describing: error))
                return
            }
            var result: UserModel?
            do{
                result = try JSONDecoder().decode(UserModel.self, from: data)
                
                if (result?.message != nil){
                    completionHandler(false, result, nil)
                } else{
                    completionHandler(true, result, nil)
                }
                
            } catch {
                completionHandler(false, nil, String(describing: error))
            }
        }
    }
    
    func fetchUserRepo(user: String, completionHandler: @escaping (Bool, [UserRepoModel]?, String?) -> Void) {
        TestUtilities.decodeFromLocalData(fileName: user) { data, error in
            guard let data = data else {
                completionHandler(false, nil, String(describing: error))
                return
            }
            var result: [UserRepoModel]?
            do{
                result = try JSONDecoder().decode([UserRepoModel].self, from: data)
                completionHandler(true, result, nil)
            } catch {
                completionHandler(false, nil, String(describing: error))
            }
        }
    }
    
    func fetchContributors(user: String, repoName: String, completionHandler: @escaping (Bool, [ContributorsModel]?, String?) -> Void) {
        TestUtilities.decodeFromLocalData(fileName: user) { data, error in
            guard let data = data else {
                completionHandler(false, nil, String(describing: error))
                return
            }
            var result: [ContributorsModel]?
            do{
                result = try JSONDecoder().decode([ContributorsModel].self, from: data)
                completionHandler(true, result, nil)
            } catch {
                completionHandler(false, nil, String(describing: error))
            }
        }
    }
}
