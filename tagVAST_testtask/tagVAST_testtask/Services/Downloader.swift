//
//  Downloader.swift
//  tagVAST_testtask
//
//  Created by Sergey Verlygo on 05/04/2022.
//

import Foundation

protocol DownloaderService: Service {
    func  loadData(with remote: URL, completion: @escaping (Result<Data?, Error>) -> Void)
}

final class DownloaderImpl: DownloaderService {
    var services: Services {
        get { _services }
        set { _services = newValue }
    }
    
    unowned var _services: Services
    
    
    let cachesURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
    var diskCacheURL: URL {
        get { cachesURL.appendingPathComponent("DownloadCache") }
    }
    
    private lazy var cache: URLCache = {
        return URLCache(memoryCapacity: 10_000_000, diskCapacity: 1_000_000_000, directory: diskCacheURL)
    }()
    
    
    private lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        config.urlCache = cache
        return URLSession(configuration: config)

    }()
    
    init(services:Services) {
        self._services = services
    }
    
    func  loadData(with remote: URL, completion: @escaping (Result<Data?, Error>) -> Void) {
        let req = URLRequest(url: remote)
        let downloadTask = session.downloadTask(with: req) { url, response, error in
            guard error == nil else {
                print("Obtaining failed with: \(error!.localizedDescription)")
                completion(.failure(error!) )
                return
            }

            print("Obtaining \(url!.lastPathComponent) complete")
            
            var resultData: Data?
            if let url = url {
                resultData = try? Data(contentsOf: url)
            }
            
            if let response = response,
               self.cache.cachedResponse(for: req) == nil,
               let data = resultData {
                    self.cache.storeCachedResponse(CachedURLResponse(response: response, data: data), for: req)
                    resultData = data
            }
            
            completion(.success(resultData))
        }
        
        downloadTask.resume()
    }
    
    
}
