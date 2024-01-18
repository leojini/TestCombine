//
//  IntSubscriber.swift
//  TestCombine
//
//  Created by Leojin on 2024/01/01.
//

import Foundation
import Combine

class IntSubscriber: Subscriber {
    typealias Input = Int
    
    typealias Failure = Never
    
    func receive(subscription: Subscription) {
        subscription.request(.max(2))
    }
    
    func receive(_ input: Int) -> Subscribers.Demand {
        print("Received value: \(input)")
        return .max(2)
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        print("Received completion: \(completion)")
    }
}
