//
//  UserViewController.swift
//  GitUserViewer
//
//  Created by Punit Kumar on 02/08/22.
//

import UIKit

class UserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UserViewModalDelegate {
    
    // MARK: - Property View Modal
    let userViewModal = UserViewModal()
    
    // MARK: - Outlets
    @IBOutlet var userHeaderView: UIView!
    @IBOutlet weak var userTableView: UITableView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userLoginLabel: UILabel!
    @IBOutlet weak var userBioLabel: UILabel!
    @IBOutlet var userCollectionView: UICollectionView!
    @IBOutlet var segmentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startSpinner()
        // MARK: - Hitting the API
        userViewModal.fetchUser(userName: userViewModal.userName ?? "")
        userViewModal.fetchUserRepo(userName: userViewModal.userName ?? "")
        userViewModal.delegate = self
        
        // MARK: - Table View
        userTableView.delegate = self
        userTableView.dataSource = self
        userTableView.tableHeaderView = userHeaderView
        userTableView.register(RepoTableViewCell.nib(), forCellReuseIdentifier: RepoTableViewCell.identifier)
        
        // MARK: - Collection View
        userCollectionView.delegate = self
        userCollectionView.dataSource = self
        userCollectionView.register(UserCountCollectionViewCell.nib(), forCellWithReuseIdentifier: UserCountCollectionViewCell.identifier)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        DispatchQueue.main.async { [weak self] in
            self?.userCollectionView.reloadData()
        }
    }
    
    // MARK: - Segment Action
    @IBAction func segmentChanged(_ sender: Any) {
        DispatchQueue.main.async { [weak self] in
            self?.userTableView.reloadData()
        }
    }
    
    // MARK: - Failure Scenerio
    func couldNotFetchUser() {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Message", message: "Could not Fetch User Data!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            self?.stopSpinner()
            self?.present(alert, animated: true)
        }
    }
    
    func couldNotFetchRepo() {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Message", message: "Could not Fetch Repository Data!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            self?.stopSpinner()
            self?.present(alert, animated: true)
        }
    }
    
    // MARK: - Updating the UI
    func updateUI() {
        DispatchQueue.main.async { [weak self] in
            self?.userImageView.downloaded(from: (self?.userViewModal.userModal?.avatar_url)!)
            self?.userImageView.circular()
            self?.userNameLabel.text = self?.userViewModal.userModal?.name ?? "Name not provided"
            self?.userLoginLabel.text = "@\(self?.userViewModal.userModal?.login ?? "")"
            self?.userBioLabel.text = self?.userViewModal.userModal?.bio ?? "Bio not provided"
            self?.stopSpinner()
        }
    }
    
    // MARK: - Reloading table through Delegate
    func reloadTable() {
        DispatchQueue.main.async { [weak self] in
            self?.userCollectionView.reloadData()
            self?.userTableView.reloadData()
        }
    }
    
    // MARK: - Setting the Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        }
        return userViewModal.userRepoModal?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contributorVC = self.storyboard?.instantiateViewController(withIdentifier: "contributorsDetails") as! ContributorViewController
        contributorVC.title = "Contributors"
        contributorVC.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "home"), style: .plain, target: self, action: #selector(homeTapped))
        contributorVC.contributorViewModal.userName = self.userViewModal.userName
        contributorVC.contributorViewModal.repoName = self.userViewModal.userRepoModal?[indexPath.row].name
        self.navigationController?.pushViewController(contributorVC, animated: true)
        userTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 100.0
        }
        return 45.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return userCollectionView
        }
        return segmentView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userTableView.dequeueReusableCell(withIdentifier: RepoTableViewCell.identifier, for: indexPath) as! RepoTableViewCell
        cell.configure(with: userViewModal.userRepoModal?[indexPath.row])
        return cell
    }
    
    // MARK: - Setting the Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userViewModal.userCollectionDataCount.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = userCollectionView.dequeueReusableCell(withReuseIdentifier: UserCountCollectionViewCell.identifier, for: indexPath) as! UserCountCollectionViewCell
        cell.configure(name: userViewModal.userCollectionDataName[indexPath.row], count: userViewModal.userCollectionDataCount[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellCount = userViewModal.userCollectionDataCount.count
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let cellSpace = flowLayout.sectionInset.left + flowLayout.sectionInset.right + (flowLayout.minimumInteritemSpacing * CGFloat((cellCount ) - 1))
        let cellSize = ((collectionView.bounds.width) - cellSpace) / CGFloat(cellCount )
        return CGSize(width: cellSize, height: collectionView.bounds.height)
    }
    
    // MARK: - Navigation Bar Button Function
    @objc func homeTapped(){
        self.navigationController?.popToViewController(of: UserViewController.self, animated: true)
    }
}
