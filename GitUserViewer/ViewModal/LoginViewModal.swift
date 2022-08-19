//
//  LoginViewModal.swift
//  GitUserViewer
//
//  Created by Punit Kumar on 02/08/22.
//

import Foundation

// MARK: - Delegate Protocol for Login View Modal
protocol LoginViewModalDelegate: AnyObject {
    func updateController()
    func updateControllerUserNotFound()
    func couldNotFetchData()
}

class LoginViewModal {
    // MARK: - Stored Properties
    let apiFetch: APIManager
    var userModal: UserModel?
    weak var delegate: LoginViewModalDelegate?
    
    init(apiFetch: APIManager = APIHandler()){
        self.apiFetch = apiFetch
    }
    
    // MARK: - Fetching Users
    func fetchUser(userName: String){
        apiFetch.fetchUser(user: userName) { [weak self] (status, result, error) in
            if status == true {
                self?.userModal = result
                self?.delegate?.updateController()
            } else if (result != nil){
                self?.userModal = result
                self?.delegate?.updateControllerUserNotFound()
            } else{
                self?.delegate?.couldNotFetchData()
            }
        }
    }
}
