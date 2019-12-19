//
//  DetailViewController.swift
//  Elements
//
//  Created by Bienbenido Angeles on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var elementImageView: UIImageView!
    @IBOutlet weak var atomicNumLabel:UILabel!
    @IBOutlet weak var atomicMassLabel: UILabel!
    @IBOutlet weak var atomicSymbolLabel: UILabel!
    @IBOutlet weak var atomicName: UILabel!
    @IBOutlet weak var elementDetailsLabel: UILabel!
    
    var element: AtomicElement?

    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
    }
    
    @IBAction func favorite(){
        guard let validElement = element else { fatalError("failed to pass element to image view")
        }
        let element = AtomicElement(name: validElement.name, symbol: validElement.symbol, number: validElement.number, atomicMass: validElement.atomicMass, melt: validElement.melt, boil: validElement.boil, discoveredBy: validElement.discoveredBy, favoritedBy: "B.A.")
        ElementAPIClient.postElements(for: element) {[weak self] (result) in
            switch result{
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "FAILURE", message: "\(appError)")
                }
            case .success:
                DispatchQueue.main.async {
                    self?.showAlert(title: "SUCCESS", message: "Podcast posted successfully")
                }
            }
        }
        
        
    }
    
    func loadData(){
        guard let validElement = element else { fatalError("failed to pass element to image view")
        }
        
        elementImageView.getImage(withURLString: "http://images-of-elements.com/\(validElement.name.lowercased()).jpg") {[weak self] (result) in
            switch result{
            case .failure:
                DispatchQueue.main.async {
                    self?.elementImageView.image = UIImage(systemName: "exclaimationmark.triangle.fill")
                }
            case .success(let image):
                self?.elementImageView.image = image
            }
        }
        atomicNumLabel.text = "\(validElement.number)"
        atomicMassLabel.text = "\(validElement.atomicMass)"
        atomicSymbolLabel.text = "\(validElement.symbol)"
        atomicName.text = "\(validElement.name)"
        elementDetailsLabel.text = "Melting Point: \(validElement.melt)\nBoiling Point: \(validElement.boil)\nDiscovered By: \(validElement.discoveredBy)"
    }
}
