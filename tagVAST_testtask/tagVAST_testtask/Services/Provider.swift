//
//  File.swift
//  tagVAST_testtask
//
//  Created by Sergey Verlygo on 05/04/2022.
//

import Foundation

protocol ProviderSearchResult: AnyObject {
    var id: String { get }
    var preview: URL { get }
}

protocol ProviderService: Service {
    func search(term:String, completion: @escaping (Result<[ProviderSearchResult], Error>) -> Void)
    func nextItems(for term: String, needed count: Int, completion: @escaping (Result<[ProviderSearchResult], Error>) -> Void)
}


class PixabayProvider: ProviderService {
    
    var services: Services {
        get { _services }
        set { _services = newValue }
    }
    
    unowned var _services: Services
    
    private var currentSearch: String? {
        willSet {
            resetCurrentSearch()
        }
    }
    
    
    init(services:Services) {
        self._services = services
    }
    
    
    func search(term: String, completion: @escaping (Result<[ProviderSearchResult], Error>) -> Void) {
        self.currentSearch = term;
    }
    
    func nextItems(for term: String, needed count: Int, completion: @escaping (Result<[ProviderSearchResult], Error>) -> Void) {
        <#code#>
    }
    
    
    private func resetCurrentSearch() {
        
    }
}
