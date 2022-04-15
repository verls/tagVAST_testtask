//
//  Config.swift
//  tagVAST_testtask
//
//  Created by Sergey Verlygo on 05/04/2022.
//

import Foundation

protocol ConfigService: Service {
    var pixabayKey: String { get }
}

final class ConfigImpl: ConfigService {
    var services: Services {
        get { _services }
        set { _services = newValue }
    }
    
    unowned var _services: Services
    
    
    // TODO: use code generation here
    let pixabayKey: String = "26529056-1581cefcd5ee5b7fbd4c79be4e2"
    
    init(services: Services) {
        self._services = services
    }
}
