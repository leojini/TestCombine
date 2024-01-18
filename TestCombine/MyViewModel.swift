//
//  ViewModel.swift
//  TestCombine
//
//  Created by Leojin on 2024/01/02.
//

import Foundation
import Combine

class MyViewModel {
    // Published 어노테이션으로 구독이 가능하도록 설정
    @Published var text1: String = "" {
        didSet {
            print("text1: \(text1)")
        }
    }
    
    @Published var text2: String = "" {
        didSet {
            print("text2: \(text2)")
        }
    }
    
    // 두 개의 Publisher를 비교하여 일치여부를 Publisher로 반환
    lazy var isMatchPasswordInput: AnyPublisher<Bool, Never> = Publishers
        .CombineLatest($text1, $text2)
        .map({(text1: String, text2: String) in
            if text1 == "" || text2 == "" {
                return false
            }
            if text1 == text2 {
                return true
            } else {
                return false
            }
        })
        .print()
        .eraseToAnyPublisher()
}
