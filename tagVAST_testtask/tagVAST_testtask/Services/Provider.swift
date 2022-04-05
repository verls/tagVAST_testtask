//
//  File.swift
//  tagVAST_testtask
//
//  Created by Sergey Verlygo on 05/04/2022.
//

import Foundation

protocol ProviderService: Service {
    func search(term:String, completion: @escaping (Result<[AnyObject], Error>) -> Void)
}


class PixabayProvider: ProviderService {
    
    var services: Services {
        get { _services }
        set { _services = newValue }
    }
    
    unowned var _services: Services
    
    init(services:Services) {
        self._services = services
    }
    
    
    func search(term: String, completion: @escaping (Result<[AnyObject], Error>) -> Void) {
        <#code#>
    }
}
