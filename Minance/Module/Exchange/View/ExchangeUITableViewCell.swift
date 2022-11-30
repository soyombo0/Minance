//
//  ExchangeUITableViewCell.swift
//  Minance
//
//  Created by Soyombo Mantaagiin on 29.11.2022.
//

import UIKit
import SnapKit

struct ExchangeTableViewCellModel {
    let name: String
    let image: String
    let price: String
}

class ExchangeUITableViewCell: UITableViewCell {
    
    static let identifier = "CustomTableViewCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private let imageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .orange
        contentView.addSubview(nameLabel)
        contentView.addSubview(imageLabel)
        contentView.addSubview(priceLabel)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.sizeToFit()
        imageLabel.sizeToFit()
        priceLabel.sizeToFit()
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(5)
            make.height.equalTo(contentView.frame.size.height/2)
            make.width.equalTo(contentView.frame.size.width/2)
        }
        imageLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(5)
            make.top.equalToSuperview().inset(contentView.frame.size.height/2)
            make.height.equalTo(contentView.frame.size.height/2)
            make.width.equalTo(contentView.frame.size.width/2)
        }
        priceLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(contentView.frame.size.width/2 )
            make.top.equalToSuperview().inset(0)
            make.height.equalTo(contentView.frame.size.height/2)
            make.width.equalTo(contentView.frame.size.width/2)
        }
    }
    
    func configure(with viewModel: ExchangeTableViewCellModel) {
        nameLabel.text = viewModel.name
        imageLabel.text = viewModel.image
        priceLabel.text = viewModel.price
    }
    
    
}
