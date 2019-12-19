//
//  FavoritedElementsViewController.swift
//  Elements
//
//  Created by Bienbenido Angeles on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class FavoritedElementsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl!
    
    var favoritedElements = [AtomicElement](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureRefreshControl()
        loadData()
        dataSources()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController, let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("failed to segue")
        }
        let favoritedElement = favoritedElements[indexPath.row]
        detailVC.element = favoritedElement
    }
    
    func configureRefreshControl(){
        refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
    }
    
    func dataSources(){
        tableView.dataSource = self
    }
    
    @objc
    func loadData(){
        ElementAPIClient.getFavoritedElements {[weak self] (result) in
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
            }
            
            switch result{
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "FAILED TO LOAD DATA", message: "\(appError)")
                }
            case .success(let elements):
                DispatchQueue.main.async {
                    self?.favoritedElements = elements.filter{$0.favoritedBy == "B.A."}
                }
            }
        }
    }
}

extension FavoritedElementsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritedElements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let favoriteElement = favoritedElements[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoritedElement", for: indexPath)
        cell.textLabel?.text = "Name:\(favoriteElement.name)"
        cell.detailTextLabel?.text = "\(favoriteElement.symbol) (\(favoriteElement.number))"
        return cell
    }
    
    
}
