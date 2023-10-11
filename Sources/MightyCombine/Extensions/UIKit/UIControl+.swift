//
//  UIControl+.swift
//  
//
//  Created by 김인섭 on 10/6/23.
//

#if canImport(UIKit)
import Combine
import UIKit

public extension UIControl {
    
    func controlPublisher(for event: UIControl.Event) -> UIControl.EventPublisher {
        .init(control: self, event: event)
    }
}

public extension UIControl {
    
    struct EventPublisher: Publisher {
        
        public typealias Output = UIControl
        public typealias Failure = Never
        
        let control: UIControl
        let event: UIControl.Event
        
        public func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, UIControl == S.Input {
            let subscription = EventSubscription(control: control, subscrier: subscriber, event: event)
            subscriber.receive(subscription: subscription)
        }
    }
    
    fileprivate class EventSubscription<EventSubscriber: Subscriber>: Subscription where EventSubscriber.Input == UIControl, EventSubscriber.Failure == Never {
        
        let control: UIControl
        let event: UIControl.Event
        var subscriber: EventSubscriber?
        
        init(control: UIControl, subscrier: EventSubscriber, event: UIControl.Event) {
            self.control = control
            self.subscriber = subscrier
            self.event = event
            
            control.addTarget(self, action: #selector(handleEvent), for: event)
        }
        
        func request(_ demand: Subscribers.Demand) {}
        
        func cancel() {
            subscriber = nil
            control.removeTarget(self, action: #selector(handleEvent), for: event)
        }
        
        @objc func handleEvent() {
            _ = subscriber?.receive(control)
        }
    }
}
#endif
