# 💪 MightyCombine

[![XCTest](https://github.com/MightyCombine/MightyCombine/actions/workflows/swift.yml/badge.svg)](https://github.com/MightyCombine/MightyCombine/actions/workflows/swift.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![Static Badge](https://img.shields.io/badge/iOS-v13-blue)
![Static Badge](https://img.shields.io/badge/Swift-v5.4-orange)

> We build powerful and convenient features using Combine and Swift only.

## ✔ Support UIKit
```swift 
button.eventPublisher(for: .touchUpInside)
    .receive(on: DispatchQueue.main)
    .sink { _ in
        print("TAP")
    }.store(in: &store)
    
textField.textPublisher
    .receive(on: DispatchQueue.main)
    .sink { text in
        print(text)
    }.store(in: &store)
```

## ✔ Support URLRequest
```swift 
URLRequest(url: url)
    .request(expect: User.self)
    .sink { _ in
        
    } receiveValue: { user in
        print(user)
    }.store(in: &store)
```

## ✔ Support async/ await and throws for AnyPublisher
```swift 
Task {
    let user = try? await userNetwork.getUser("octopus").asyncThrows
    print(user)
}
```

## ✔ asyncMap and asyncThrowsMap
```swift 
userNetwork.getUser("octocat")
    .asyncMap({ user in
        await doSomething(use)
    })
    .sink(receiveCompletion: { _ in
        
    }, receiveValue: { _ in
        
    }).store(in: &store)

userNetwork.getUser("octocat")
    .asyncThrowsMap({ user in
        try await doSomething()
    })
    .sink(receiveCompletion: { _ in
        
    }, receiveValue: { _ in
        
    }).store(in: &store)
```

## ✔ Support XCTest
```swift
// Given
let sut: UserNetwork = .init()
sut.getUser = { _ in .inject(.fail(NSError())) }

Task {
    // When
    let user = try? await sut.getUser("octopus").asyncThrows
    
    // Then
    XCTAssertNil(user)
}
```

```swift 
// Given
let sut: UserNetwork = .init()
let mockData = User(login: "octopus", id: 112233)
sut.getUser = { _ in .inject(.success(mockData)) }

Task {
    // When
    let user = try? await sut.getUser("octopus").asyncThrows
    
    // Then
    XCTAssertNotNil(user)
    if let user {
        XCTAssertEqual(mockData.id, user.id)
    }
}
```

# 💪 MightySwift

## ✔ EndPoint
```Swift
EndPoint
    .init("https://api.github.com")
    .urlPaths(["/users", "/octocat"])
    .httpHeaders(["Accept": "application/vnd.github+json"])
    .httpMethod(.get)
    .urlRequest // return URLRequest
    .request(expect: User.self) // return AnyPublisher<User, Error>
    .sink { _ in
        
    } receiveValue: { user in
        print(user)
    }.store(in: &store)
```

## ✔ URLRequest Extension
```swift
let urlRequest = URLRequest
    .init("https://api.github.com")
    .urlPaths(["/users", "/octocat"])
    .httpHeaders(["Accept": "application/vnd.github+json"])
    .httpMethod(.get)
```
