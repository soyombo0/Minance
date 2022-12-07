//
//  SavedSecondView.swift
//  Minance
//
//  Created by Soyombo Mantaagiin on 6.12.2022.
//

import UIKit

protocol SavedSecondViewOutput {
    func tableViewDidDismiss(name: String, symbol: String, price: String, imageUrl: URL?, imageData: Data?)
}

class SavedSecondView: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

//  VARIABLES
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(SavedUITableViewCell.self, forCellReuseIdentifier: SavedUITableViewCell.identifier)
        tableView.backgroundColor = .systemBackground
        return tableView
    }()

    private var viewModels = [SavedUITableViewCellModel]()
    
    private var savedData = [SavedList]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let searchView = UISearchController(searchResultsController: nil)
    
    var delegate: SavedSecondViewOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = view.bounds
        loadData()
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
        delegate?.tableViewDidDismiss(name: viewModels[indexPath.row].label, symbol: viewModels[indexPath.row].symbol, price: viewModels[indexPath.row].price, imageUrl: viewModels[indexPath.row].imageUrl, imageData: viewModels[indexPath.row].imageData)
        dismiss(animated: true)
    }
}
