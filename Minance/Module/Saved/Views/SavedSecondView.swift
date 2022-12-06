//
//  SavedSecondView.swift
//  Minance
//
//  Created by Soyombo Mantaagiin on 6.12.2022.
//

import UIKit

class SavedSecondView: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

//  VARIABLES
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(SavedUITableViewCell.self, forCellReuseIdentifier: SavedUITableViewCell.identifier)
        tableView.backgroundColor = .systemBackground
        return tableView
    }()
    
    let SavedVC = SavedViewController().tableView
    
    private var viewModels = [SavedUITableViewCellModel]()
    
    private var savedData = [SavedList]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let searchView = UISearchController(searchResultsController: nil)
    
    var searchArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = view.bounds
        loadData()
//        searchBar()
    }

// Funcs
    func loadData() {
        FetchingData.shared.parseData { [weak self] result in
            switch result {
            case .success(let models):
                
                self?.viewModels = models.compactMap( {
                    SavedUITableViewCellModel(
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
    
//    func searchBar() {
//        navigationItem.searchController = searchView
//        searchView.searchBar.delegate = self
//    }
    
    func getItems() {
        do {
            savedData = try context.fetch(SavedList.fetchRequest())
            DispatchQueue.main.async {
                self.SavedVC.reloadData()
            }
        }
        catch {
            
        }
    }
    
    func createItem(name: String, symbol: String, price: String, imageUrl: URL?, imageData: Data?) {
        let newItem = SavedList(context: context)
        newItem.name = name
        newItem.symbol = symbol
        newItem.price = price
        newItem.imageUrl = imageUrl
        newItem.imageData = imageData
        
        do {
            try context.save()
            getItems()
        }
        catch {
            
        }
    }
}

// MARK: ExchangeViewcontroller
extension SavedSecondView {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SavedUITableViewCell.identifier, for: indexPath) as? SavedUITableViewCell else { fatalError() }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.createItem(name: viewModels[indexPath.row].label,
                        symbol: viewModels[indexPath.row].symbol,
                        price: viewModels[indexPath.row].price,
                        imageUrl: viewModels[indexPath.row].imageUrl,
                        imageData: viewModels[indexPath.row].imageData
        )
    }
}
