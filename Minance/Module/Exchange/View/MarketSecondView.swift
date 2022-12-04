//
//  MarketSecondView.swift
//  Minance
//
//  Created by Soyombo Mantaagiin on 2.12.2022.
//

import UIKit
import SnapKit

struct MarketViewModel {
    let label: String
    let symbol: String
    let price: String
}

class MarketSecondView: UIViewController {
    
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32, weight: .medium)
        return label
    }()
    
    let symbolLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .right
        return label
    }()
    
    let highPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .right
        return label
    }()
    
    let lowPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .right
        return label
    }()
    
    let totalSupplyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .right
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setView()
    }
    
    private func setView() {
        
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(30)
        }
        
        view.addSubview(symbolLabel)
        symbolLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel).inset(50)
        }
        
        view.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(symbolLabel).inset(100)
        }
        
        view.addSubview(highPriceLabel)
        highPriceLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(priceLabel).inset(80)
        }
        
        
        view.addSubview(lowPriceLabel)
        lowPriceLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(highPriceLabel).inset(30)
        }
        
        
        view.addSubview(totalSupplyLabel)
        totalSupplyLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(highPriceLabel).inset(80)
        }
        
    }
}
