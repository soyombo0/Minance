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
    var imageUrl: URL?
    var imageData: Data? = nil
    let highPrice: String
    let lowPrice: String
    let totalSupply: String

    
    init(
        label: String,
        symbol: String,
        price: String,
        imageUrl: URL?,
        highPrice: String,
        lowPrice: String,
        totalSupply: String
    ) {
        self.label = label
        self.symbol = symbol
        self.price = price
        self.imageUrl = imageUrl
        self.highPrice = highPrice
        self.lowPrice = lowPrice
        self.totalSupply = totalSupply
    }
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
    
    private let coinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(symbolLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(coinImageView)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.sizeToFit()
        symbolLabel.sizeToFit()
        priceLabel.sizeToFit()
        
        coinImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(16)
            make.height.width.equalTo(35)
        }
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(coinImageView).inset(40)
            make.top.equalToSuperview().inset(3)
            make.height.equalTo(contentView.frame.size.height/2)
            make.width.equalTo(contentView.frame.size.width/2)
        }
        symbolLabel.snp.makeConstraints { make in
            make.left.equalTo(coinImageView).inset(40)
            make.top.equalToSuperview().inset(contentView.frame.size.height/2)
            make.height.equalTo(contentView.frame.size.height/2)
            make.width.equalTo(contentView.frame.size.width/2)
        }
        priceLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.height.equalTo(contentView.frame.size.height/2)
            make.width.equalTo(contentView.frame.size.width/2)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        symbolLabel.text = nil
        priceLabel.text = nil
        coinImageView.image = nil
    }
    
    func configure(with viewModel: ExchangeTableViewCellModel) {
        nameLabel.text = viewModel.label
        symbolLabel.text = viewModel.symbol
        priceLabel.text = viewModel.price
        
        if let data = viewModel.imageData {
            coinImageView.image = UIImage(data: data)
        }
        else if let url = viewModel.imageUrl {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else { return }
                var viewModel = viewModel
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.coinImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }   
    
    
}
