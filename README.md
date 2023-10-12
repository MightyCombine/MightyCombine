# 💪 MightyCombine

[![XCTest](https://github.com/MightyCombine/MightyCombine/actions/workflows/swift.yml/badge.svg)](https://github.com/MightyCombine/MightyCombine/actions/workflows/swift.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![Static Badge](https://img.shields.io/badge/iOS-v13-blue)
![Static Badge](https://img.shields.io/badge/Swift-5.4-orange)

> We build powerful and convenient features using Combine and Swift.

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
    .requestPublisher(expect: User.self)
    .sink { _ in
        
    } receiveValue: { user in
        print(user)
    }.store(in: &store)
```

## ✔ Support EndPoint
```Swift
EndPoint
    .init("https://api.github.com")
    .urlPaths(["/users", "/octocat"])
    .requestPublisher(expect: User.self)
    .sink { _ in
        
    } receiveValue: { user in
        print(user)
    }.store(in: &store)
```

## ✔ Support async/ await and throws
```swift 
Task {
    let user = try? await userNetwork.getUser("octopus").asyncThrows
    print(user)
}
```

## ✔ Support asyncMap and asyncThrowsMap
```swift 
userNetwork.getUser("octocat")
    .asyncMap({ user in
        await doSomething()
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

## ✔ Support optionalThrows
```swift 
let value = Just(1)
    .setFailureType(to: Error.self)
    .receive(on: DispatchQueue.main)
    .optionalThrows // Optional(1)
    
let value: Int? = Fail(error: NSError())
    .receive(on: DispatchQueue.main)
    .optionalThrows // nil
```

## ✔ Support XCTest
```swift
// Given
let sut: UserNetwork = .init()
sut.getUser = { _ in .inject(.failure(NSError())) }

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
let users: [User] = [.....]
let user = users.find(\.login, "octocat") // Optional(User(login: "octocat"))
```

## ✔ Optional Extension 
```swift
let optionalValue: Int? = nil
let result = optionalValue.replaceNil(with: 10)
print(result) // 10
```

## ✔ URLRequest Extension
```swift
let urlRequest = URLRequest
    .init("https://api.github.com")
    .urlPaths(["/users", "/octocat"])
```
