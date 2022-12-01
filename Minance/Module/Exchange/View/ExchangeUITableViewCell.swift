//
//  ExchangeUITableViewCell.swift
//  Minance
//
//  Created by Soyombo Mantaagiin on 29.11.2022.
//

import UIKit
import SnapKit

struct ExchangeTableViewCellModel {
    let label: String
    let symbol: String
    let price: String
}

class ExchangeUITableViewCell: UITableViewCell {
    
    static let identifier = "CustomTableViewCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private let symbolLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .right
        return label
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(symbolLabel)
        contentView.addSubview(priceLabel)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.sizeToFit()
        symbolLabel.sizeToFit()
        priceLabel.sizeToFit()
        imageView?.sizeToFit()
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(15)
            make.top.equalToSuperview().inset(3)
            make.height.equalTo(contentView.frame.size.height/2)
            make.width.equalTo(contentView.frame.size.width/2)
        }
        symbolLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(15)
            make.top.equalToSuperview().inset(contentView.frame.size.height/2)
            make.height.equalTo(contentView.frame.size.height/2)
            make.width.equalTo(contentView.frame.size.width/2)
        }
        priceLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(contentView.frame.size.width/2 - 10)
            make.centerY.equalToSuperview()
            make.height.equalTo(contentView.frame.size.height/2)
            make.width.equalTo(contentView.frame.size.width/2)
        }
    }
    
    func configure(with viewModel: ExchangeTableViewCellModel) {
        nameLabel.text = viewModel.label
        symbolLabel.text = viewModel.symbol
        priceLabel.text = viewModel.price
    }
    
    
}
