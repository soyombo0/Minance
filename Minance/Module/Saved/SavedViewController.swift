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
        tableView.register(UITableViewCell.self
                           , forCellReuseIdentifier: "cell")
        return tableView
    }()
    
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
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func getItems() {
        do {
            savedData = try context.fetch(SavedList.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch {
            //ie
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
        }
        catch {
            
        }
    }
    
    private func setView() {
        view.addSubview(mainLabel)
        mainLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}

extension SavedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let data = savedData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Guten Tag"
        return cell
    }
    
    
}
