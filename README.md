# 💪 MightyCombine

## ✔ Use async/ await with Combine
### AnyPublisher -> async/await throws
```swift 
let userNetwork: UserNetwork = .init()

userNetwork.getUser("octopus")
    .receive(on: DispatchQueue.main)
    .sink { _ in
        
    } receiveValue: { user in
        print(user)
    }.store(in: &store)

Task {
    let user = try? await sut.getUser("octopus").asyncThrows
    print(user)
}
```

## ✔ Inject mock easily for XCTest
### Inject Fail
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

### Inject Success
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
