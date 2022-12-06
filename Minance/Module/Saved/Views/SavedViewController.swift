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
        tableView.register(ExchangeUITableViewCell.self, forCellReuseIdentifier: ExchangeUITableViewCell.identifier)
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
//        let alert = UIAlertController(title: "New Item", message: "Enter new Item", preferredStyle: .alert)
//        alert.addTextField(configurationHandler: nil)
//        alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { [weak self] _ in
//            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else {
//                return
//            }
//
//            self?.createItem(name: text)
//        }))
//
//        present(alert, animated: true)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: ExchangeUITableViewCell.identifier, for: indexPath)
        cell.textLabel?.text = data.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
//        let item = savedData[indexPath.row]
        
//        let sheet = UIAlertController(title: "Edit", message: nil, preferredStyle: .alert)
//        sheet.addTextField(configurationHandler: nil)
//        sheet.addAction(UIAlertAction(title: "Edit", style: .cancel, handler: { _ in
//
//            let alert = UIAlertController(title: "Edit", message: "Edit your item", preferredStyle: .alert)
//            alert.addTextField(configurationHandler: nil)
//            alert.textFields?.first?.text = item.name
//            alert.addAction(UIAlertAction(title: "Save", style: .cancel, handler: { _ in
//                guard let field = alert.textFields?.first, let newName = field.text, !newName.isEmpty else {
//                    return
//                }
//
//                self.updateItem(item: item, newName: newName)
//            }))
//
//            self.present(alert, animated: true)
//        }))
//        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
//            self?.deleteItem(item: item)
//        }))
//        sheet.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { _ in }))
//        present(sheet, animated: true)
    }
    
    
}
