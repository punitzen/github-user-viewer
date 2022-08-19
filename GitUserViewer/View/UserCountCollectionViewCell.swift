//
//  UserCountCollectionViewCell.swift
//  GitUserViewer
//
//  Created by Punit Kumar on 02/08/22.
//

import UIKit

class UserCountCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Stored Properties
    static let identifier = "UserCountCollectionViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var dataNameLabel: UILabel!
    @IBOutlet weak var dataCountLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Configuring the cell
    func configure(name: String?, count: Int?){
        dataNameLabel.text = name
        dataCountLabel.text = "\(RoundNumberUtility.roundedWithAbbreviations(count ?? 0))"
    }
    
    // MARK: - Function for Registering Nib
    static func nib() -> UINib {
        return UINib(nibName: "UserCountCollectionViewCell", bundle: nil)
    }
}
