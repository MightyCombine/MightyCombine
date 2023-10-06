# 💪 MightyCombine

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

## ✔ Support async/ await
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
