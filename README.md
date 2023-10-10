# 💪 MightyCombine

[![XCTest](https://github.com/MightyCombine/MightyCombine/actions/workflows/swift.yml/badge.svg)](https://github.com/MightyCombine/MightyCombine/actions/workflows/swift.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![Static Badge](https://img.shields.io/badge/iOS-v13-blue)
![Static Badge](https://img.shields.io/badge/Swift-v5.4-orange)

> We build powerful and convenient features using Combine and Swift only.

## ✔ Support UIKit
```swift 
button.eventPublisher(for: .touchUpInside)
    .sink { _ in
        print("TAP")
    }.store(in: &store)
    
textField.textPublisher
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
let userNetwork: UserNetwork = .init()

userNetwork.getUser("octopus")
    .sink { _ in
        
    } receiveValue: { user in
        print(user)
    }.store(in: &store)

Task {
    let user = try? await userNetwork.getUser("octopus").asyncThrows
    print(user)
}
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

## ✔ Array Extension
```swift
let users: [User] = [.....] // 11 Elements
let user = users.find(\.id, value: 10) // Optional(User(id: 10, login: "John"))
let user = users[safe: 0] // Optional(User(id: 0, login: "Alice"))
let user = users[safe: 20] // nil
```

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
