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
    
    private var viewModels = [ExchangeTableViewCellModel]()
    
    let searchView = UISearchController(searchResultsController: nil)
    
// Layouts
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        loadData()
        searchBar()
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
                        imageUrl: URL(string: $0.image)
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
        controller.coinImageView.image = 
        present(controller, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }
        print(text)
    }
}
