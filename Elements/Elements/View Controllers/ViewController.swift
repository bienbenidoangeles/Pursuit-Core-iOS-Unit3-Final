//
//  ViewController.swift
//  Elements
//
//  Created by Alex Paul on 12/31/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var elements = [Element](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    loadData()
    dataSources()
  }
    
    func loadData(){
        ElementAPIClient.getElements { (result) in
            switch result{
            case .failure(let appError):
                DispatchQueue.main.async {
                    self.showAlert(title: "Failed to load Data", message: "\(appError)")
                }
            case .success(let elements):
                self.elements = elements
            }
        }
    }
    
    func dataSources(){
        tableView.dataSource = self
    }


}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "elementCell", for: indexPath) as? ElementCell else {
            fatalError("failed to deque")
        }
        
        let element = elements[indexPath.row]
        cell.configureCell(for: element)
        
        return cell
    }
    
    
}

