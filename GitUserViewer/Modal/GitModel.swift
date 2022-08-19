//
//  GitModal.swift
//  GitUserViewer
//
//  Created by Punit Kumar on 01/08/22.
//

import Foundation

// MARK: - User Modal
struct UserModel: Decodable {
    let login: String?
    let id: Int?
    let avatar_url: String?
    let name: String?
    let company: String?
    let bio: String?
    let followers: Int?
    let public_repos: Int?
    let following: Int?
    let message: String?
}

// MARK: - Repository Modal
struct UserRepoModel: Decodable {
    let name: String?
    let visibility: String?
    let description: String?
    let language: String?
    let forks: Int?
    let stargazers_count: Int?
    let updated_at: String?
    let topics: [String]?
}

// MARK: - Contributor Modal
struct ContributorsModel: Decodable {
    let login: String
    let avatar_url: String?
    let contributions: Int?
}
