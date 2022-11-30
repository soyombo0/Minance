//
//  ExchangeViewController.swift
//  Minance
//
//  Created by Soyombo Mantaagiin on 28.11.2022.
//
import Foundation
import UIKit
import SnapKit

class ExchangeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(ExchangeUITableViewCell.self, forCellReuseIdentifier: ExchangeUITableViewCell.identifier)
        
        return tableView
    }()
    
    private var viewModels = [ExchangeTableViewCellModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.ba
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        FetchingData.shared.parseData { [weak self] result in
            switch result {
            case .success(let models):
                self?.viewModels = models.compactMap( {
                    ExchangeTableViewCellModel(
                        label: $0.name,
                        symbol: $0.symbol,
                        price: "\(round($0.currentPrice * 1000) / 1000.0)")
                })
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
            case .failure(let error):
                print("error: \(error)")
            }
        }
        tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExchangeUITableViewCell.identifier, for: indexPath) as? ExchangeUITableViewCell else { fatalError() }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
}


