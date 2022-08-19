//
//  ContributorViewModal.swift
//  GitUserViewer
//
//  Created by Punit Kumar on 02/08/22.
//

import Foundation

// MARK: - Delegate Protocol for Contributor View Modal
protocol ContributorViewModalDelegate: AnyObject {
    func reloadTable()
    func couldNotFetchContributors()
}

class ContributorViewModal {
    // MARK: - Stored Properties
    var userName: String?
    var repoName: String?
    let apiFetch: APIManager
    weak var delegate: ContributorViewModalDelegate?
    var contributorModal: [ContributorsModel]? = [ContributorsModel]() {
        didSet {
            self.delegate?.reloadTable()
        }
    }
    
    init(apiFetch: APIManager = APIHandler()){
        self.apiFetch = apiFetch
    }
    
    // MARK: - Fetching Contributors
    func fetchContributor(userName: String, repoName: String) {
        apiFetch.fetchContributors(user: userName, repoName: repoName) { [weak self] (status, result, error) in
            guard status == true else {
                self?.delegate?.couldNotFetchContributors()
                print(String(describing: error))
                return
            }
            guard let result = result else {
                return
            }
            self?.contributorModal = result
        }
    }
}
