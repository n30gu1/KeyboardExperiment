//
//  ViewController.swift
//  KeyboardExperiment
//
//  Created by Park Seongheon on 5/24/24.
//

import UIKit

class ViewController: UIViewController {
    var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        
        configureNavigation()
        configureStack()
        configureUI()
    }
    
    func configureNavigation() {
        navigationItem.title = "Keyboard Experiment"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureStack() {
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func configureUI() {
        let label: UILabel = {
            let l = UILabel()
            l.text = "Stack is working quite well"
            return l
        }()
        
        let anotherLabel: UILabel = {
            let l = UILabel()
            l.text = "Stack is working quite well"
            return l
        }()

        let anotherStack = UIStackView()
        anotherStack.addArrangedSubview(anotherLabel)
        anotherStack.addArrangedSubview(anotherLabel)
        
        anotherStack.axis = .horizontal

        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(anotherStack)
    }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: ViewController())
}
#endif
