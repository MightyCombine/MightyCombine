# 💪 MightyCombine

We build powerful and convenient features using Combine and Swift only.

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
    .receive(on: DispatchQueue.main)
    .sink { _ in
        
    } receiveValue: { user in
        print(user)
    }.store(in: &store)
```

## ✔ Support async/ await and throws for AnyPublisher
```swift 
let userNetwork: UserNetwork = .init()

userNetwork.getUser("octopus")
    .receive(on: DispatchQueue.main)
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
let urlRequest = EndPoint
    .init("https://api.github.com")
    .urlPaths(["/users", "/octocat"])
    .httpHeaders(["Accept": "application/vnd.github+json"])
    .httpMethod(.get)
    .urlRequest
```

## ✔ URLRequest Extension
```swift
let urlRequest = URLRequest
    .init("https://api.github.com")
    .urlPaths(["/users", "/octocat"])
    .httpHeaders(["Accept": "application/vnd.github+json"])
    .httpMethod(.get)
```
