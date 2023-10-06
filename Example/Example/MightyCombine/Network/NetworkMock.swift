//
//  NetworkMock.swift
//  
//
//  Created by 김인섭 on 10/5/23.
//

import Foundation

public enum NetworkMock {
    case success(Data), fail(Error)
}
