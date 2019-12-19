//
//  ElementCell.swift
//  Elements
//
//  Created by Bienbenido Angeles on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementCell: UITableViewCell {
    
    @IBOutlet weak var elementImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var elementDetails: UILabel!
    
    private var elementImageString:String? = ""

    override func prepareForReuse() {
        super.prepareForReuse()
        elementImageView.image = nil
    }
    
    
    
    func configureCell(for element: AtomicElement){
        self.elementImageString = "http://www.theodoregray.com/periodictable/Tiles/\(String(format: "%03d", element.number))/s7.JPG" 
        guard let validURLString = self.elementImageString else {
            return
        }
        
        elementImageView.getImage(withURLString: validURLString) {[weak self] (result) in
            switch result{
            case .failure:
                DispatchQueue.main.async {
                    self?.elementImageView.image = UIImage(systemName: "exclamationmark.triangle.fill")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    if self?.elementImageString == validURLString{
                        self?.elementImageView.image = image
                    }
                }
            }
        }
        
        nameLabel.text = element.name
        elementDetails.text = "\(element.symbol)(\(element.number)) \(element.atomicMass)"
    }

}
