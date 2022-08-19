//
//  LoginTableViewController.swift
//  GitUserViewer
//
//  Created by Punit Kumar on 01/08/22.
//

import UIKit

class LoginTableViewController: UITableViewController, LoginViewModalDelegate {
    // MARK: - Stored Property for View Modal
    let loginViewModal = LoginViewModal()
    
    // MARK: - Outlets
    @IBOutlet weak var loginTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginViewModal.delegate = self
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // MARK: - Conforming Protocols
    func updateController() {
        DispatchQueue.main.async { [weak self] in
            let userVC = self?.storyboard?.instantiateViewController(withIdentifier: "userDetails") as! UserViewController
            userVC.title = self?.loginViewModal.userModal?.name
            userVC.userViewModal.userName = self?.loginViewModal.userModal?.login
            self?.navigationController?.pushViewController(userVC, animated: true)
        }
    }
    
    func updateControllerUserNotFound() {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Message", message: "User not Found!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            self?.present(alert, animated: true)
        }
    }
    
    func couldNotFetchData() {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Message", message: "Could not Fetch Data!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            self?.present(alert, animated: true)
        }
    }
    
    // MARK: - Outlet Actions
    @IBAction func loginButtonTapped(_ sender: Any) {
        guard let username = loginTextField.text, !username.isEmpty, !username.contains(" ") else {return}
        loginViewModal.fetchUser(userName: username)
    }
}
