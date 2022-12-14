//
//  ExchangeViewController.swift
//  Minance
//
//  Created by Soyombo Mantaagiin on 28.11.2022.
//
import Foundation
import UIKit


class ExchangeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

//  VARIABLES
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(ExchangeUITableViewCell.self, forCellReuseIdentifier: ExchangeUITableViewCell.identifier)
        return tableView
    }()
    
    lazy var refresher: UIRefreshControl = {
        let refreshing = UIRefreshControl()
        refreshing.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshing
    }()
    
    private var viewModels = [ExchangeTableViewCellModel]()
    
    let searchView = UISearchController(searchResultsController: nil)
    
    var searchArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.refreshControl = refresher
        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = view.bounds
        loadData()
        searchBar()
    }

// Funcs
    
    @objc private func refresh(sender: UIRefreshControl) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            sender.endRefreshing()
        }
    }
    
    func loadData() {
        FetchingData.shared.parseData { [weak self] result in
            switch result {
            case .success(let models):
                
                self?.viewModels = models.compactMap( {
                    ExchangeTableViewCellModel(
                        label: $0.name,
                        symbol: $0.symbol,
                        price: "\(round($0.currentPrice * 1000) / 1000.0)",
                        imageUrl: URL(string: $0.image),
                        highPrice: "\($0.high24H)",
                        lowPrice: "\($0.low24H)",
                        totalSupply: "\($0.totalSupply ?? 0)"
                )})
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
            case .failure(let error):
                print("error: \(error)")
            }
        }
        tableView.reloadData()
    }
    
    func searchBar() {
        navigationItem.searchController = searchView
        searchView.searchBar.delegate = self
    }
}

// MARK: ExchangeViewcontroller
extension ExchangeViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExchangeUITableViewCell.identifier, for: indexPath) as? ExchangeUITableViewCell else { fatalError() }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let controller = MarketSecondView()
        controller.modalPresentationStyle = .formSheet
        controller.nameLabel.text = viewModels[indexPath.row].label
        controller.symbolLabel.text = viewModels[indexPath.row].symbol
        controller.priceLabel.text = viewModels[indexPath.row].price
        controller.highPriceLabel.text = viewModels[indexPath.row].highPrice
        controller.lowPriceLabel.text = viewModels[indexPath.row].lowPrice
        controller.totalSupplyLabel.text = viewModels[indexPath.row].totalSupply
        
//        controller.coinImageView.image = UIImage(data: viewModels[indexPath.row].imageData)
        present(controller, animated: true)
    }
    
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        guard let text = searchBar.text, !text.isEmpty else { return }
//
//        FetchingData.shared.parseData { [weak self] result in
//            switch result {
//            case .success(let models):
//
//                self?.viewModels = models.compactMap( {
//                    ExchangeTableViewCellModel(
//                        label: $0.name,
//                        symbol: $0.symbol,
//                        price: "\(round($0.currentPrice * 1000) / 1000.0)",
//                        imageUrl: URL(string: $0.image)
//                )})
//
//                DispatchQueue.main.async {
//                    self?.tableView.reloadData()
//                }
//
//            case .failure(let error):
//                print("error: \(error)")
//            }
//        }
//        tableView.reloadData()
//    }
}
