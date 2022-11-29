//
//  ExchangeUITableViewCell.swift
//  Minance
//
//  Created by Soyombo Mantaagiin on 29.11.2022.
//

import UIKit

class ExchangeUITableViewCell: UITableViewCell {
    
    static let identifier = "CustomCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .orange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
