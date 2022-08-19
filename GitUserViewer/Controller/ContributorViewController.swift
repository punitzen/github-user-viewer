//
//  ContributorViewController.swift
//  GitUserViewer
//
//  Created by Punit Kumar on 02/08/22.
//

import UIKit

class ContributorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ContributorViewModalDelegate {
    
    // MARK: - Property View Modal
    let contributorViewModal = ContributorViewModal()
    
    // MARK: - Outlets
    @IBOutlet var contributorTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.startSpinner()
        // MARK: - Hitting the API
        contributorViewModal.fetchContributor(userName: contributorViewModal.userName ?? "", repoName: contributorViewModal.repoName ?? "")
        
        // MARK: - Table View
        contributorViewModal.delegate = self
        contributorTableView.delegate = self
        contributorTableView.dataSource = self
        contributorTableView.register(ContributorsTableViewCell.nib(), forCellReuseIdentifier: ContributorsTableViewCell.identifier)
    }
    
    // MARK: - Failure Secenerio
    func couldNotFetchContributors() {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Message", message: "Could not Fetch Contributors Data!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            self?.stopSpinner()
            self?.present(alert, animated: true)
        }
    }
    
    // MARK: - Reloading the table through delegate
    func reloadTable() {
        DispatchQueue.main.async { [weak self] in
            self?.contributorTableView.reloadData()
            self?.stopSpinner()
        }
    }
    
    // MARK: - Setting Table View
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userVC = self.storyboard?.instantiateViewController(withIdentifier: "userDetails") as! UserViewController
        self.navigationController?.pushViewController(userVC, animated: true)
        userVC.title = self.contributorViewModal.contributorModal?[indexPath.row].login
        userVC.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "home"), style: .plain, target: self, action: #selector(homeTapped))
        userVC.userViewModal.userName = self.contributorViewModal.contributorModal?[indexPath.row].login
        contributorTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contributorViewModal.contributorModal?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contributorTableView.dequeueReusableCell(withIdentifier: ContributorsTableViewCell.identifier, for: indexPath) as! ContributorsTableViewCell
        cell.configure(with: contributorViewModal.contributorModal?[indexPath.row])
        return cell
    }
    
    // MARK: - Navigation Bar Button Function
    @objc func homeTapped(){
        self.navigationController?.popToViewController(of: UserViewController.self, animated: true)
    }
}
