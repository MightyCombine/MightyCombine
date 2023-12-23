# 💪 MightyCombine

[![XCTest](https://github.com/MightyCombine/MightyCombine/actions/workflows/swift.yml/badge.svg)](https://github.com/MightyCombine/MightyCombine/actions/workflows/swift.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![Static Badge](https://img.shields.io/badge/iOS-v13-blue)
![Static Badge](https://img.shields.io/badge/Swift-5.4-orange)

> We build powerful and convenient features using Combine and Swift.

> Support Network, Log, Functional, Asynchronous, Endpoint and more

## ✔ Support Operaters
```swift 
Just("Value")
    ✅ asyncMap
    .asyncMap({ value in
        await doSomething()
    })
    .sink(receiveCompletion: { _ in
        
    }, receiveValue: { _ in
        
    }).store(in: &store)

Just("Value")
    ✅ asyncThrowsMap
    .asyncThrowsMap({ user in
        try await doSomething()
    })
    .sink(receiveCompletion: { _ in
        
    }, receiveValue: { _ in
        
    }).store(in: &store)
    
Just("Value")
    .setFailureType(to: TestError.self)
    ✅ mapToResult
    .mapToResult()
    .sink { result in
        switch result {
        case .success(let success):
            print(success) // "Value"
        case .failure(_):
            
        }
        expectation.fulfill()
    }.store(in: &store)
    
Fail<Any, TestError>(error: TestError.testError)
    ✅ mapToResult
    .mapToResult()
    .sink { result in
        switch result {
        case .success(_):
            
        case .failure(let failure):
            print(failure) // TestError.testError
        }
        expectation.fulfill()
    }.store(in: &store)
```

## ✔ Support async/ await and throws
```swift 
Task {
    ✅ asyncThrows
    let result = try? await Just("Value").asyncThrows
    print(result) // Optional("Value")

    ✅ asyncOptionalTry
    let result = await Fail(error: TestError.testError).asyncOptionalTry
    print(result) // nil

    ✅ asyncReplaceError
    let result = await Fail(error: TestError.testError).asyncReplaceError(with: 10)
    print(result) // 10

    ✅ async
    let result = await Just(1).async
    print(result) // 1
    
    ✅ asyncResult - Success
    let result = await Just("Value).asyncResult
    print(result) // success("Value")
    
    ✅ asyncResult - Failure
    let result = await Fail<Any, TestError>(error: TestError.testError).asyncResult
    print(result) // failure(TestSource.TestError.testError)
}
```

## ✔ Support EndPoint
```Swift
✅ EndPoint
EndPoint
    .init("https://api.github.com")
    .urlPaths(["/users", "/octocat"])
    ✅ resoinseHandler
    .responseHandler(handleResponse(_:))
    ✅ requestPublisher
    .requestPublisher(expect: User.self)
    .sink { _ in
        
    } receiveValue: { user in
        print(user)
    }.store(in: &store)
```

## ✔ Support File Upload and MultiPartFormData 
```swift
let formData = MultiPartFormData()
let bodyData = formData.bodyData(    
    data: data,
    parameters: parameters,
    name: "image",
    filename: "imagename.png",
    mimeType: "image/png"
)

EndPoint
    .init(basURL)
    .urlPaths(paths)
    .httpHeaders(formData.headers)
    .httpMethod(.post)
    .uploadPublisher(from: bodyData, expect: Response.self)
    .sink { _ in
        
    } receiveValue: { _ in
        
    }.store(in: &store)
```

## ✔ Support XCTest
```swift
// Given
let sut: UserNetwork = .init()
✅ inject fail
sut.getUser = { _ in .inject(.failure(NSError())) }

// When
✅ asyncThrows
let user = try? await sut.getUser("octopus").asyncThrows

// Then
XCTAssertNil(user)
```

```swift 
// Given
let sut: UserNetwork = .init()
let mockData = User(login: "octopus", id: 112233)
✅ inject success
sut.getUser = { _ in .inject(.success(mockData)) }
    
// When
✅ asyncThrows
let user = try? await sut.getUser("octopus").asyncThrows 

// Then
XCTAssertNotNil(user)
if let user {
    XCTAssertEqual(mockData.id, user.id)
}       
```

```swift
let url = URL(string: "https://api.github.com/users/octopus")!
✅ inject HTTPURLResponse
let response = HTTPURLResponse(
    url: url,
    statusCode: 500,
    httpVersion: nil,
    headerFields: nil
)
✅ MockURLSession
let mockSession = MockURLSession(response: response)
```

## ✔ Support Network Log
```swift
✅ printLog
URLSession.printLog = true
✅ logStyle
URLSession.requestLogStyle = .string
URLSession.responseLogStyle = .string

EndPoint
    .init(basURL)
    .urlPaths(paths)
    ✅ logStyle for each endpoint
    .requestLogStyle(.json) // request data will print pretty json  
    .responseLogStyle(.non) // will not print body 
    .requestPublisher(expect: User.self)
```

## ✔ Support URLRequest
```swift 
URLRequest(url: url)
    ✅ requestPublisher
    .requestPublisher(expect: User.self)
    .sink { _ in
        
    } receiveValue: { user in
        print(user)
    }.store(in: &store)
```

## ✔ Config JSONDecoder
```swift
let decoder = JSONDecoder()
decoder.keyDecodingStrategy = .keyDecodingStrategy

URLSession.decoder = decoder 
```

## ✔ Support UIKit
```swift 
✅ eventPublisher
button.eventPublisher(for: .touchUpInside).sink { _ in
    print("TAP")
}.store(in: &store)
    
✅ textPublisher
textField.textPublisher.sink { text in
    print(text)
}.store(in: &store)

✅ controlPublisher
tableRefresh.controlPublisher(for: .valueChanged).sink { _ in
    print("Pulled")
}.store(in: &store)

✅ tapGesturePublisher    
uiView.tapGesturePublisher.sink { _ in 
    print("Tap")
}.store(in: &store)
    
✅ switchPublisher
uiSwitch.switchPublisher.sink {
    print($0)
}.store(in: &store)
```

# 💪 MightySwift

## ✔ Array Extension 
```swift 
let users: [User] = [.....]
✅ find
let user = users.find(\.login, "octocat") // Optional(User(login: "octocat"))
```

## ✔ Optional Extension 
```swift
let optionalValue: Int? = nil
✅ replaceNil
let result = optionalValue.replaceNil(with: 10)
print(result) // 10
```

## ✔ URLRequest Extension
```swift
let urlRequest = URLRequest
    .init("https://api.github.com")
    ✅ urlPaths
    .urlPaths(["/users", "/octocat"])
    ✅ and more
    // .urlQueries
    // .httpMethod
    // .httpBody
    // .httpHeaders
    // .requestPublisher
```

## ✔ SelfReturnable
```swift
final class DefaultViewController: UIViewController, SelfReturnable { }

    let controller = DefaultViewController()
        .with(\.title, "Hello")
        .with(\.hidesBottomBarWhenPushed, true)
```
