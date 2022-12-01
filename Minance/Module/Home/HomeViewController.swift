//
//  HomeViewController.swift
//  Minance
//
//  Created by Soyombo Mantaagiin on 28.11.2022.
//

import UIKit
import SnapKit


protocol HomeViewControllerInput {
    
}

protocol HomeViewControllerOutput {
    
}

class HomeViewController: UIViewController {
    
    let fiatTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Fiat"
        textField.textAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 22)
        textField.backgroundColor = .systemGray5
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    let coinTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Coin"
        textField.textAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 22)
        textField.backgroundColor = .systemGray5
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setView()
    }
    
    
    private func setView() {
        view.addSubview(fiatTextField)
        fiatTextField.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
        
        view.addSubview(coinTextField)
        coinTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(fiatTextField).inset(50)
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
    }

}
