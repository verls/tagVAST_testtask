//
//  Errors.swift
//  tagVAST_testtask
//
//  Created by Sergey Verlygo on 05/04/2022.
//

import Foundation

enum AppErrors: Error {
    case internalInconsistency
    case parsing
}

extension AppErrors: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .internalInconsistency:
            return NSLocalizedString("Internal inconsistency", comment: "")
        case .parsing:
            return NSLocalizedString("Parsing error", comment: "")
        }
    }
}
