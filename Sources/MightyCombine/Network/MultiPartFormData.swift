//
//  MultiPartFormData.swift
//
//
//  Created by 김인섭 on 10/17/23.
//

import Foundation

public struct MultiPartFormData {
    
    let boundary = "Boundary-\(UUID().uuidString)"

    public var headers: [String: String] {
        ["Content-Type": "multipart/form-data; boundary=\(boundary)"]
    }

    public func bodyData(
        data: Data,
        parameters: [String: Any],
        name: String,
        filename: String,
        mimeType: String
    ) -> Data {
        var bodyData = Data()
        let boundaryPrefix = "--\(self.boundary)\r\n"
        for (key, value) in parameters {
            bodyData.append(boundaryPrefix.data(using: .utf8)!)
            bodyData.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            bodyData.append("\(value)\r\n".data(using: .utf8)!)
        }
        bodyData.append(boundaryPrefix.data(using: .utf8)!)
        bodyData.append("Content-Disposition: form-data; name=\"\(name)\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
        bodyData.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
        bodyData.append(data)
        bodyData.append("\r\n".data(using: .utf8)!)
        bodyData.append("--\(self.boundary)--".data(using: .utf8)!)
        return bodyData
    }
    
    public init() { }
}
