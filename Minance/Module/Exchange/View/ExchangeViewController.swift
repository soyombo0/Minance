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
    
    var apiData = FetchingData()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        apiData = FetchingData()
        tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiData.coins.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExchangeUITableViewCell.identifier, for: indexPath)
//        cell.textLabel?.text = apiData.coins[indexPath.row].name
//        cell.imageView?.image = UIView
        return cell
    }
    
}


