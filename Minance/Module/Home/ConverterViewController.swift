//
//  HomeViewController.swift
//  Minance
//
//  Created by Soyombo Mantaagiin on 28.11.2022.
//

import UIKit
import SnapKit


protocol ConverterViewControllerInput {
    
}

protocol ConverterViewControllerOutput {
    
}



class ConverterViewController: UIViewController {
    
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
        textField.inputView = UIPickerView()
        return textField
    }()
    
    let coinAmountLabel: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Coin amount"
        textField.textAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 22)
        textField.backgroundColor = .systemGray5
        textField.layer.cornerRadius = 10
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    let dollarImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "dollarsign")
        image.tintColor = .systemGray
        return image
    }()
    
    let bitcoinImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "bitcoinsign")
        image.tintColor = .systemGray
        return image
    }()
    
    let pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        loadData()
        hideKeyboard()
        view.backgroundColor = .systemBackground
        pickerView.delegate = self
        pickerView.dataSource = self
        coinAmountLabel.delegate = self
        coinTextField.inputView = pickerView
    }
    
    private func loadData() {
        FetchingData.shared.parseData { result in
            switch result {
            case .success(let models):
                models.forEach({
                    self.nameData.append($0.name)
                    self.priceData.append("\($0.currentPrice)")
                })
            case .failure(let error):
                print("error: \(error)")
            }
        }

    }
    
    private func setView() {
        
        view.addSubview(coinTextField)
        coinTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(30)
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
        
        view.addSubview(usdPriceLabel)
        usdPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(coinTextField).inset(50)
            make.right.equalToSuperview().inset(50)
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
        
        view.addSubview(dollarImage)
        dollarImage.snp.makeConstraints { make in
            make.right.equalTo(usdPriceLabel).inset(155)
            make.bottom.equalTo(usdPriceLabel).inset(4)
        }
        
        view.addSubview(coinAmountLabel)
        coinAmountLabel.snp.makeConstraints { make in
            make.bottom.equalTo(coinTextField).inset(50)
            make.right.equalToSuperview().inset(50)
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
        
        view.addSubview(bitcoinImage)
        bitcoinImage.snp.makeConstraints { make in
            make.right.equalTo(coinAmountLabel).inset(155)
            make.bottom.equalTo(coinAmountLabel).inset(4)
        }
    }

}


extension ConverterViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
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
