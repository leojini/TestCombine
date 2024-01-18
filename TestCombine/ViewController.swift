//
//  ViewController.swift
//  TestCombine
//
//  Created by Leojin on 2024/01/01.
//

import UIKit
import Combine

class ViewController: UIViewController {

    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = .black
        searchController.searchBar.searchTextField.accessibilityIdentifier = "mySearchBarTextField"
        return searchController
    }()

    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var searchLabel: UILabel!
    
    var viewModel: MyViewModel!
    private var disposables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = MyViewModel()
        
        // 뷰 모델의 text1이 텍스트 필드 퍼블리셔를 구독
        textField1.textFieldPublisher
            .receive(on: RunLoop.main)
            // 인스턴스 키로 속성에 할당
            // .assign(to: \.text1, on: viewModel)
            .sink { [weak self] receiveValue in
                self?.viewModel.text1 = receiveValue
            }
            .store(in: &disposables)
        
        // 뷰 모델의 text2이 텍스트 필드 퍼블리셔를 구독
        textField2.textFieldPublisher
            .receive(on: RunLoop.main)
            // 인스턴스 키로 속성에 할당
            .assign(to: \.text2, on: viewModel)
            .store(in: &disposables)
        
        // 버튼이 뷰 모델의 퍼블리셔를 구독
        viewModel.isMatchPasswordInput
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: button)
            .store(in: &disposables)
        
        self.navigationItem.searchController = searchController
        searchController.isActive = true
        searchController.searchBar.searchTextField
            .searchPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] receiveValue in
                print("receiveValue: \(receiveValue)")
                self?.searchLabel.text = receiveValue
            }
            .store(in: &disposables)
        
        test()
    }
    
    func test() {
        let numbers = [1, 2, 3, 4, 5]
        let mapped = numbers.map { Array(repeating: $0, count: 2)}
        let flatMapped = numbers.flatMap { Array(repeating: $0, count: 2)}
        print("mapped: \(mapped)")
        print("flatMapped: \(flatMapped)")
    }
}

extension UITextField {
    var textFieldPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { $0.object as? UITextField }
            .map { $0.text ?? "" }
//            .print()
            .eraseToAnyPublisher()
    }
}

extension UIButton {
    var isValid: Bool {
        get {
            backgroundColor == .yellow
        }
        set {
            backgroundColor = newValue ? .yellow : .lightGray
            isEnabled = newValue
            setTitleColor(newValue ? .blue : .white, for: .normal)
        }
    }
}

extension UISearchTextField {
    var searchPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(for: UISearchTextField.textDidChangeNotification, object: self)
            .compactMap { $0.object as? UISearchTextField }
            .map { $0.text ?? "" }
            .debounce(for: .milliseconds(1000), scheduler: RunLoop.main)
            .filter { $0.count > 0 }
            .eraseToAnyPublisher()
    }
}
