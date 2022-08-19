//
//  APIManager.swift
//  GitUserViewer
//
//  Created by Punit Kumar on 01/08/22.
//

import Foundation

// MARK: - Protocol for Hitting API
protocol APIManager {
    func fetchUser(user: String, completionHandler: @escaping (_ status: Bool, _ result: UserModel?, _ error: String?) -> Void)
    func fetchUserRepo(user: String, completionHandler: @escaping (_ status: Bool, _ result: [UserRepoModel]?, _ error: String?) -> Void)
    func fetchContributors(user: String, repoName: String, completionHandler: @escaping (_ status: Bool, _ result: [ContributorsModel]?, _ error: String?) -> Void)
}

// MARK: - API Class conforming API protocol
class APIHandler: APIManager {
    
    // MARK: - Fetching User
    func fetchUser(user: String, completionHandler: @escaping (Bool, UserModel?, String?) -> Void) {
        let url = "https://api.github.com/users/" + user
        
        NetworkAPIHandler.APIContract(url) { data, response, error in
            guard let data = data, error == nil else{
                completionHandler(false, nil, String(describing: error))
                print("couldnt get user data")
                return
            }
            
            var result: UserModel?
            
            do {
                result = try JSONDecoder().decode(UserModel.self, from: data)
                
                if result?.message == nil {
                    completionHandler(true, result, nil)
                } else{
                    completionHandler(false, result, nil)
                }
            } catch {
                completionHandler(false, nil, String(describing: error))
            }
        }
    }
    
    // MARK: - Fetching Repositories
    func fetchUserRepo(user: String, completionHandler: @escaping (Bool, [UserRepoModel]?, String?) -> Void) {
        let url = "https://api.github.com/users/" + user + "/repos"
        
        NetworkAPIHandler.APIContract(url) { data, response, error in
            guard let data = data, error == nil else{
                completionHandler(false, nil, String(describing: error))
                print("couldnt get repo data")
                return
            }
            
            var result: [UserRepoModel]?
            
            do {
                result = try JSONDecoder().decode([UserRepoModel].self, from: data)
                completionHandler(true, result, nil)
            } catch {
                completionHandler(false, nil, String(describing: error))
            }
        }
    }
    
    // MARK: - Fetching Contributors
    func fetchContributors(user: String, repoName: String, completionHandler: @escaping (Bool, [ContributorsModel]?, String?) -> Void) {
        let url = "https://api.github.com/repos/" + user + "/" + repoName + "/contributors"
        
        NetworkAPIHandler.APIContract(url) { data, response, error in
            guard let data = data, error == nil else{
                completionHandler(false, nil, String(describing: error))
                print("couldnt get contributors data")
                return
            }
            
            var result: [ContributorsModel]?
            
            do {
                result = try JSONDecoder().decode([ContributorsModel].self, from: data)
                completionHandler(true, result, nil)
            } catch {
                completionHandler(false, nil, String(describing: error))
            }
        }
    }
}

