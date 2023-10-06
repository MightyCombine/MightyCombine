# MightyCombine

## Example

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
