//
//  SavedViewController.swift
//  Minance
//
//  Created by Soyombo Mantaagiin on 28.11.2022.
//

import UIKit
import SnapKit

class SavedViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var savedData = [SavedList]()
    
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
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onTap))
    }
    
    @objc private func onTap() {
        let itemsView = SavedSecondView()
        itemsView.modalPresentationStyle = .formSheet
        present(itemsView, animated: true)
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
    
    func createItem(name: String) {
        let newItem = SavedList(context: context)
        newItem.name = name
        
        do {
            try context.save()
            getItems()
        }
        catch {
            
        }
    }
    
    func saveItem(name: String) {
        let newItem = SavedList(context: context)
        newItem.name = name
        
        do {
            try context.save()
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
    
    func updateItem(item: SavedList, newName: String) {
        item.name = newName
        do {
            try context.save()
            getItems()
        }
        catch {
            
        }
    }
    
}

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
