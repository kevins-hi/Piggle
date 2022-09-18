//
//  SearchResult.swift
//  Piggle
//
//  Created by Kevin Shi on 9/17/22.
//

import Foundation

struct SearchResult: Codable {
    struct OrganicResults: Codable {
        let position: Int
        let title: String
        let link: String
        let snippet: String
    }
    let organic_results: [OrganicResults]
}
