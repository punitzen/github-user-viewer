//
//  TopicsCollectionViewCell.swift
//  GitHubRepoClone
//
//  Created by Punit Kumar on 30/07/22.
//

import UIKit

class TopicsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Stored Properties
    static let identifier = "TopicsCollectionViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var topic: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Configuring the cell
    func configure(with title: String?){
        topic.text = title
    }
    
    // MARK: - Registering Nib
    static func nib() -> UINib {
        return UINib(nibName: "TopicsCollectionViewCell", bundle: nil)
    }
}
