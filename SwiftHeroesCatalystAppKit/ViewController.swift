//
//  ViewController.swift
//  SwiftHeroesCatalystAppKit
//
//  Created by Benedikt Terhechte on 11.04.21.
//

import UIKit

class ViewController: UIViewController {
    
    var adapter: AppKitAdapter?
    
    let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.setTitle("Hello World", for: .normal)
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        button.addAction(UIAction(handler: { (_) in
            self.adapter?.showWindow()
            self.button.isHidden = true
        }), for: .touchUpInside)
    }

    @objc(actionForSelection:)
    func actionForSelection(_ value: String) {
        button.setTitle(value, for: .normal)
        self.button.isHidden = false
    }
}

