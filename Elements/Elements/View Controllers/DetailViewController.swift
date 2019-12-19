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
    @IBOutlet weak var elementDetailsLabel: UILabel!
    
    var element: Element?

    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
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
        atomicMassLabel.text = "\(validElement.symbol)"
        
        elementDetailsLabel.text = "Melting Point: \(validElement.melt)\nBoiling Point: \(validElement.boil)\nDiscovered By: \(validElement.discoveredBy)"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
