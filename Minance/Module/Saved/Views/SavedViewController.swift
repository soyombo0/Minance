//
//  SavedViewController.swift
//  Minance
//
//  Created by Soyombo Mantaagiin on 28.11.2022.
//

import UIKit
import SnapKit

class SavedViewController: UIViewController, SavedSecondViewOutput {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var savedData = [SavedList]()
    
    lazy var refresher: UIRefreshControl = {
        let refreshing = UIRefreshControl()
        refreshing.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshing
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SavedUITableViewCell.self, forCellReuseIdentifier: SavedUITableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        getItems()
        tableView.refreshControl = refresher
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(onTap))
    }

    // Functions
    
    @objc private func refresh(sender: UIRefreshControl) {
        DispatchQueue.main.async {
            self.getItems()
            sender.endRefreshing()
        }
    }
    
    @objc private func onTap() {
        let itemsView = SavedSecondView()
        itemsView.delegate = self
        itemsView.modalPresentationStyle = .formSheet
        present(itemsView, animated: true)
    }
    
    func tableViewDidDismiss(name: String, symbol: String, price: String, imageUrl: URL?, imageData: Data?) {
        createItem(name: name, symbol: symbol, price: price, imageUrl: imageUrl, imageData: imageData)
    }

    
    func getItems() {
        do {
            savedData = try context.fetch(SavedList.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
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
    
    func deleteItem(item: SavedList) {
        context.delete(item)
        
        do {
            try context.save()
            getItems()
        }
        catch {
            
        }
    }
}

// MARK: SavedViewController
extension SavedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = savedData[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SavedUITableViewCell.identifier, for: indexPath) as? SavedUITableViewCell else { fatalError() }
        cell.configureVC(with: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.deleteItem(item: savedData[indexPath.row])
    }
    
}
