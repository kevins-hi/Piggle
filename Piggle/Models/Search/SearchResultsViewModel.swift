//
//  SearchResultsViewModel.swift
//  Piggle
//
//  Created by Kevin Shi on 9/17/22.
//

import Foundation

struct SearchResultsViewModel {
    let searchResult: SearchResult.OrganicResults
    
    var position: Int {
        return searchResult.position
    }
    
    var title: String {
        return searchResult.title.capitalized
    }
    
    var link: String {
        return searchResult.link
    }
    
    var snippet: String {
        return searchResult.snippet
    }
}
