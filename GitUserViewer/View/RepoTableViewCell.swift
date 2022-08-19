//
//  RepoTableViewCell.swift
//  GitHubRepoClone
//
//  Created by Punit Kumar on 29/07/22.
//

import UIKit

class RepoTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    // MARK: - Stored Properties
    static let identifier = "RepoTableViewCell"
    let defaultLabel = "Not Provided"
    var topicsArray: [String]?
    let dateUtility = DateUtility()
    
    // MARK: - Outlets
    @IBOutlet weak var repoImageView: UIImageView!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var repoDescLabel: UILabel!
    @IBOutlet weak var repoLangLabel: UILabel!
    @IBOutlet weak var repoStarCountLabel: UILabel!
    @IBOutlet weak var repoForkCountLabel: UILabel!
    @IBOutlet weak var repoUpdatedAt: UILabel!
    @IBOutlet weak var topicsCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var repoView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // MARK: - Collection View
        topicsCollectionView.register(TopicsCollectionViewCell.nib(), forCellWithReuseIdentifier: TopicsCollectionViewCell.identifier)
        topicsCollectionView.delegate = self
        topicsCollectionView.dataSource = self
        
        //MARK: - Configuring Cell View
        repoView.layer.cornerRadius = 15
        repoView.layer.shadowColor = UIColor.lightGray.cgColor
        repoView.layer.shadowOpacity = 1
        repoView.layer.shadowOffset = .zero
        repoView.layer.shadowRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Configuring the cell
    func configure(with model: UserRepoModel?){
        self.topicsArray =  model?.topics
        
        if topicsArray?.count == 0 {
            topicsCollectionView.isHidden = true
            collectionViewHeight.constant = 10
        } else {
            topicsCollectionView.isHidden = false
            collectionViewHeight.constant = 35
        }
        
        repoImageView.circular()
        repoNameLabel.text = "\(model?.name ?? defaultLabel) 🌎"
        repoDescLabel.text = model?.description ?? defaultLabel
        repoLangLabel.text = "🟠 \(model?.language ?? defaultLabel)"
        repoStarCountLabel.text = "⭐ \(model?.stargazers_count ?? 0)"
        repoForkCountLabel.text = "\(model?.forks ?? 0)"
        repoUpdatedAt.text = dateUtility.timeDateDifference(repoDate: model?.updated_at ?? "")
        self.topicsCollectionView.reloadData()
    }
    
    // MARK: - Function for registering nib
    static func nib() -> UINib {
        return UINib(nibName: "RepoTableViewCell", bundle: nil)
    }
    
    // MARK: - Setting Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topicsArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = topicsCollectionView.dequeueReusableCell(withReuseIdentifier: TopicsCollectionViewCell.identifier, for: indexPath) as! TopicsCollectionViewCell
        guard let topicData = topicsArray else { return cell }
        cell.configure(with: topicData[indexPath.row])
        return cell
    }
}
