//
//  MultiPartFormData+.swift
//
//
//  Created by 김인섭 on 10/20/23.
//

import Foundation

public extension MultiPartFormData {
    
    func data(_ data: Data) -> Self {
        var new = self
        new.data = data
        return new
    }
 
    func parameters(_ parameters: [String: Any]) -> Self {
        var new = self
        new.parameters = parameters
        return new
    }
    
    func name(_ name: String) -> Self {
        var new = self
        new.name = name
        return new
    }
    
    func filename(_ filename: String) -> Self {
        var new = self
        new.filename = filename
        return new
    }
    
    func mimeType(_ mimeType: String) -> Self {
        var new = self
        new.mimeType = mimeType
        return new
    }
}
