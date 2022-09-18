//
//  SearchResults.swift
//  Piggle
//
//  Created by Kevin Shi on 9/17/22.
//

import SwiftUI

struct SearchResults: View {
    @StateObject var searchResultsListVM: SearchResultsListViewModel
    @Binding var search: String
   
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Spacer()
                    
                    Text(search)
                        .padding(.vertical, 10)
                    
                    Spacer()
                }
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color("Gray"))
                        .padding(.horizontal, 10)
                    
                    Spacer()
                }
            }
            .foregroundColor(Color("DarkGray"))
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("LightGray"), lineWidth: 1.3))
            .padding(.horizontal, 10)
            .padding(.bottom, 5)

            ZStack {
                List(searchResultsListVM.searchResults, id: \.position) { result in
                    VStack(alignment: .leading) {
                        Button(action: {
                            if let url = URL(string: result.link) {
                                UIApplication.shared.open(url)
                            }
                        }, label: {
                            Text(result.title)
                                .font(.title2)
                                .frame(height: 25)
                                .truncationMode(.tail)
                                .foregroundColor(.blue)
                        })
                        
                        Text(result.snippet)
                            .foregroundColor(Color("DarkGray"))
                    }
                }
                .listStyle(PlainListStyle())

                if searchResultsListVM.isLoading {
                    ZStack {
                        Color(.systemBackground)
                            .opacity(0.3)
                            .ignoresSafeArea()

                        ProgressView("Fetching Results")
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color(.systemBackground))
                            )
                            .shadow(color: Color("Shadow"), radius: 5)
                    }
                }
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .alert(item: $searchResultsListVM.appError) { appAlert in
            Alert(title: Text("Error"),
                  message: Text("\(appAlert.errorString)"))
        }
    }
}

struct SearchResults_Previews: PreviewProvider {
    static var previews: some View {
        let searchResultsListVM = SearchResultsListViewModel()
        searchResultsListVM.query = "potato"
        searchResultsListVM.getSearchResults()
        return SearchResults(searchResultsListVM: searchResultsListVM, search: .constant("potato"))
    }
}
