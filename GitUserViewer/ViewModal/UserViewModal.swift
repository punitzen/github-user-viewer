//
//  UserViewModal.swift
//  GitUserViewer
//
//  Created by Punit Kumar on 02/08/22.
//

import Foundation

// MARK: - Delegate Protocol for User View Modal
protocol UserViewModalDelegate: AnyObject {
    func updateUI()
    func reloadTable()
    func couldNotFetchUser()
    func couldNotFetchRepo()
}

class UserViewModal {
    // MARK: - Stored Properties
    var userName: String?
    var userCollectionDataCount = [Int]()
    let userCollectionDataName = ["repositories", "followers", "following"]
    let apiFetch: APIManager
    weak var delegate: UserViewModalDelegate?
    var userModal: UserModel? {
        didSet{
            self.userCollectionDataCount.append(self.userModal?.public_repos ?? 0)
            self.userCollectionDataCount.append(self.userModal?.followers ?? 0)
            self.userCollectionDataCount.append(self.userModal?.following ?? 0)
            self.delegate?.updateUI()
            self.delegate?.reloadTable()
        }
    }
    var userRepoModal: [UserRepoModel]? = [UserRepoModel]() {
        didSet{
            self.delegate?.reloadTable()
        }
    }
    
    init(apiFetch: APIManager = APIHandler()){
        self.apiFetch = apiFetch
    }
    
    // MARK: - Fetching User
    func fetchUser(userName: String){
        apiFetch.fetchUser(user: userName) { [weak self] (status, result, error) in
            guard status == true else {
                self?.delegate?.couldNotFetchUser()
                print(String(describing: error))
                return
            }
            self?.userModal = result
        }
    }
    
    // MARK: - Fetching Repositories
    func fetchUserRepo(userName: String){
        apiFetch.fetchUserRepo(user: userName) { [weak self] (status, result, error) in
            guard status == true else {
                self?.delegate?.couldNotFetchRepo()
                print(String(describing: error))
                return
            }
            guard let result = result else {
                return
            }
            self?.userRepoModal = result
        }
    }
}
