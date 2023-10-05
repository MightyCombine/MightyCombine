# PowerfulCombine

## Example

### Inject Fail
```swift
// Given
let session = URLSession.mockSession
let url = URL(string: "https://api.github.com/users/octocat")!
var urlRequest: URLRequest { .init(url: url) }

Task {
    // When
    let user: User? = try? await session.request(urlRequest)
        .mock(.fail(NSError()))
        .asyncThrows
    
    // Then
    XCTAssertNil(user)
}
```

### Inject Success
```swift 
// Given
let network = URLSession.mockSession
let url = URL(string: "https://api.github.com/users/octocat")!
var urlRequest: URLRequest { .init(url: url) }

Task {
    // When
    let expect = User(login: "octocat", id: 20506834)
    let user: User? = try? await session.request(urlRequest)
        .mock(.success(expect))
        .asyncThrows
    
    // Then
    XCTAssertNotNil(user)
    if let user {
        XCTAssertEqual(expect.id, user.id)
    }
}
```
