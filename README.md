# MightyCombine

## Example1: Use async/ await with Combine
### AnyPublisher
```swift 
let userNetwork: UserNetwork = .init()
userNetwork.getUser("octopus")
    .receive(on: DispatchQueue.main)
    .sink { _ in
        
    } receiveValue: { user in
        print(user)
    }.store(in: &store)
```

### AnyPublisher -> async/await throws
```swift 
let userNetwork: UserNetwork = .init()
Task {
    let user = try? await sut.getUser("octopus").asyncThrows
    print(user)
}
```

## Example2: Inject mock easily for XCTest
### Inject Fail
```swift
// Given
var sut: UserNetwork = .init()

sut.getUser = { _ in .mock(.fail(NSError())) }

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
var sut: UserNetwork = .init()

let mockData = User(login: "octopus", id: 112233)
sut.getUser = { _ in .mock(.success(mockData)) }

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
