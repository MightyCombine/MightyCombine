//
//  UIView+.swift
//
//
//  Created by 김인섭 on 11/3/23.
//

#if canImport(UIKit)
import Combine
import UIKit

public extension UIView {
    
    var tapGesturePublisher: AnyPublisher<Void, Never> {
        TapGesturePublisher(view: self)
            .subscribe(on: DispatchQueue.main)
            .map { _ in }
            .eraseToAnyPublisher()
    }
}

fileprivate extension UIView {
    
    struct TapGesturePublisher: Publisher {
        
        public typealias Output = UITapGestureRecognizer
        public typealias Failure = Never

        let view: UIView

        public func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
            let tapGesture = TapGestureRecognizer()
            view.addGestureRecognizer(tapGesture)
            let subscription = TapGestureSubscription(subscriber: subscriber, gesture: tapGesture)
            subscriber.receive(subscription: subscription)
        }
    }
    
    class TapGestureRecognizer: UITapGestureRecognizer {
        
        let tapped = PassthroughSubject<UITapGestureRecognizer, Never>()
        
        override init(target: Any?, action: Selector?) {
            super.init(target: target, action: action)
            self.addTarget(self, action: #selector(tap))
        }
        
        @objc private func tap(sender: UITapGestureRecognizer) {
            tapped.send(sender)
        }
    }


    class TapGestureSubscription<S: Subscriber>: Subscription where S.Input == UITapGestureRecognizer, S.Failure == Never {
        
        private var subscriber: S?
        private var gesture: TapGestureRecognizer?
        
        init(subscriber: S, gesture: TapGestureRecognizer) {
            self.subscriber = subscriber
            self.gesture = gesture
            
            gesture.tapped.sink { [weak self] tap in
                _ = self?.subscriber?.receive(tap)
            }
            .store(in: &cancellables)
        }
        
        func request(_ demand: Subscribers.Demand) { }

        func cancel() {
            subscriber = nil
            gesture = nil
        }
        
        private var cancellables = Set<AnyCancellable>()
    }

}
#endif
