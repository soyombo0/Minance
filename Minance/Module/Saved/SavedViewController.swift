//
//  SavedViewController.swift
//  Minance
//
//  Created by Soyombo Mantaagiin on 28.11.2022.
//

import UIKit
import SnapKit

class SavedViewController: UIViewController {
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "SavedViewController"
        label.font = UIFont.systemFont(ofSize: 32)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setView()
        
    }
    
    
    private func setView() {
        view.addSubview(mainLabel)
        mainLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
