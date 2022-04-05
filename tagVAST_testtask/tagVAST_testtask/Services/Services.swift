//
//  Services.swift
//  tagVAST_testtask
//
//  Created by Sergey Verlygo on 05/04/2022.
//

import Foundation

protocol Service: AnyObject {
    var services: Services { get set }
}


class Services {
    private var services: [String:Service] = [:]
    
    func append<P>(_ proto:P.Type, implementation: Service) -> Void {
        let key = keyFor(aProto: proto.self)
        services[key] = implementation
        implementation.services = self
    }
    
    func resolve<P>(_ proto:P.Type) -> Service? {
        let key = keyFor(aProto: proto.self)
        return services[key]
    }
    
    func keyFor<P>(aProto: P.Type) -> String {
        return ("\(aProto)")
    }
}

