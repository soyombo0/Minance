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
    var fiatPrice = "0.0"
    
    let viewModel = [ExchangeTableViewCellModel]()
    
    let usdPriceLabel: UITextField = {
        let textField = UITextField()
        textField.placeholder = "USD price"
        textField.textAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 22)
        textField.backgroundColor = .systemGray5
        textField.layer.cornerRadius = 10
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    let coinTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Choose coin"
        textField.textAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 22)
        textField.backgroundColor = .systemGray5
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    let coinAmountLabel: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Coin amount"
        textField.textAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 22)
        textField.backgroundColor = .systemGray5
        textField.layer.cornerRadius = 10
        textField.keyboardType = .numbersAndPunctuation
        return textField
    }()
    
    
    
    var pickerView = UIPickerView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setView()
        pickerView.delegate = self
        pickerView.dataSource = self
        coinAmountLabel.delegate = self
        coinTextField.inputView = pickerView
        loadData()
        hideKeyboard()
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
        view.addSubview(usdPriceLabel)
        usdPriceLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
        
        view.addSubview(coinTextField)
        coinTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(usdPriceLabel).inset(50)
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
        
        view.addSubview(coinAmountLabel)
        coinAmountLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(usdPriceLabel).inset(50)
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
    }

}


extension HomeViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )
        view.addGestureRecognizer(tap)
    }
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let fiat = Double(fiatPrice) ?? 1.0
        let usd = Double(coinAmountLabel.text ?? "1") ?? 1.0
        usdPriceLabel.text = "\(fiat * usd)"
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        coinAmountLabel.resignFirstResponder()
        return true
    }
    
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
        usdPriceLabel.text = priceData[row]
        fiatPrice = priceData[row]
        coinTextField.resignFirstResponder()
        usdPriceLabel.resignFirstResponder()
        
        
    }
    
}
