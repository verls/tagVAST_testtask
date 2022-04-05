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


class ProviderItem: ProviderSearchResult {
    var id: String
    var preview: URL
    
    init(id:String,with preview: URL) {
        self.id = id
        self.preview = preview
    }
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
    
    private var downloader: DownloaderService? {
        get {
            return services.resolve(DownloaderService.self) as? DownloaderService
        }
    }
    private var config: ConfigService? {
        get {
            return services.resolve(ConfigService.self) as? ConfigService
        }
    }
    
    
    init(services:Services) {
        self._services = services
    }
    
    
    func search(term: String, completion: @escaping (Result<[ProviderSearchResult], Error>) -> Void) {
        self.currentSearch = term;
        
        guard let downloader = downloader, let conf = config else {
            completion(.failure(AppErrors.internalInconsistency))
            return
        }
        
        guard let queryURL = makeRequestURL(search: term, apiKey: conf.pixabayKey) else {
            completion(.failure(AppErrors.internalInconsistency))
            return
        }
        
        
        downloader.loadData(with: queryURL) { result in
            switch result {
            case .failure(let err): completion(.failure(err))
            case .success(let data):
                guard let resp = self.response(from: data) else {
                    completion(.failure(AppErrors.parsing))
                    return
                }
                
                completion(.success([]))
            }
        }

        
        
    }
    
    func nextItems(for term: String, needed count: Int, completion: @escaping (Result<[ProviderSearchResult], Error>) -> Void) {
        
    }
    
    
    private func resetCurrentSearch() {
        
    }
    
    private func makeRequestURL(search: String, apiKey: String) -> URL? {
        
        guard let s = search.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return nil
        }
        let sURL = "https://pixabay.com/api/videos/?key=\(apiKey)&q=\(s)&pretty=true";
        return URL(string: sURL)
    }
    
    private func response(from data: Data?) -> Pixabay.Response? {
        guard let data = data else {
            return nil
        }

        return try? JSONDecoder().decode(Pixabay.Response.self, from: data)
    }
}
