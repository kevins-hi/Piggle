//
//  SearchResultsListViewModel.swift
//  Piggle
//
//  Created by Kevin Shi on 9/17/22.
//

import CoreLocation
import Foundation
import SwiftUI

class SearchResultsListViewModel: ObservableObject {
    struct AppError: Identifiable {
        let id = UUID().uuidString
        let errorString: String
    }
    
    @Published var searchResults: [SearchResultsViewModel] = []
    var appError: AppError? = nil
    @Published var isLoading: Bool = false
    @Published var query = ""
    
    init() {
        getSearchResults()
    }
    
    func getSearchResults() {
        UIApplication.shared.endEditing()
        if query == "" {
            searchResults = []
        } else {
            isLoading = true
            let apiService = APIServiceCombine.shared
            apiService.getJSON(urlString: "https://serpapi.com/search.json?engine=google&q=\(self.query)&location=United%20States&api_key=\(APIKeys.serpAPI)") { (result: Result<SearchResult,APIServiceCombine.APIError>) in
                switch result {
                case .success(let searchResult):
                    DispatchQueue.main.async {
                        self.isLoading = false
                        self.searchResults = searchResult.organic_results.map {SearchResultsViewModel(searchResult: $0)}
                    }
                case .failure(let apiError):
                    switch apiError {
                    case .error(let errorString):
                        self.isLoading = false
                        self.appError = AppError(errorString: errorString)
                        print(errorString)
                    }
                }
            }
        }
    }
}
