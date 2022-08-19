//
//  ContributorsTableViewCell.swift
//  GitHubRepoClone
//
//  Created by Punit Kumar on 31/07/22.
//

import UIKit

class ContributorsTableViewCell: UITableViewCell {
    
    // MARK: - Stored Properties
    static let identifier = "ContributorsTableViewCell"

    // MARK: - Outlets
    @IBOutlet weak var contributorNameLabel: UILabel!
    @IBOutlet weak var contributorImageView: UIImageView!
    @IBOutlet weak var contributorContributionsLabel: UILabel!
    @IBOutlet weak var contributorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //MARK: - Configuring Cell View
        contributorView.layer.cornerRadius = 15
        contributorView.layer.shadowColor = UIColor.lightGray.cgColor
        contributorView.layer.shadowOpacity = 1
        contributorView.layer.shadowOffset = .zero
        contributorView.layer.shadowRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Configuring the cell
    func configure(with contriModel: ContributorsModel?){
        contributorNameLabel.text = contriModel?.login
        contributorContributionsLabel.text = "Contributions: \(contriModel?.contributions ?? 0)"
        contributorImageView.downloaded(from: (contriModel?.avatar_url)!)
        contributorImageView.circular()
    }
    
    // MARK: - Registering Nib
    static func nib() -> UINib {
        return UINib(nibName: "ContributorsTableViewCell", bundle: nil)
    }
}
