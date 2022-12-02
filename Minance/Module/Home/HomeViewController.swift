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
    
    var priceData = [String]()
    var nameData = [String]()
    
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
        textField.placeholder = "Bitcoin"
        textField.textAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 22)
        textField.backgroundColor = .systemGray5
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    var pickerView = UIPickerView()
    
    var picker = ["sdasd", "sdsad"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setView()
        pickerView.delegate = self
        pickerView.dataSource = self
        coinTextField.inputView = pickerView
        loadData()
    }
    
    private func loadData() {
        FetchingData.shared.parseData { [self] result in
            switch result {
            case .success(let models):
                models.map({
                    self.nameData.append($0.name)
                    self.priceData.append("\($0.currentPrice)")
                })
            case .failure(let error):
                print("error: \(error)")
            }
        }

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

extension HomeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return nameData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return nameData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinTextField.text = nameData[row]
        coinTextField.resignFirstResponder()
        fiatTextField.text = priceData[row]
    }
    
}
