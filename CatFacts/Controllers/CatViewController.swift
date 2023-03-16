//
//  CatViewController.swift
//  CatFacts
//
//  Created by Rameez Khan on 3/10/23.
//

import UIKit

class CatViewController: UIViewController {

    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var factLabel: UILabel!
    
    private let viewModel = CatViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped(gestureRecognizer:)))
               view.addGestureRecognizer(tapRecognizer)

        viewModel.text.bind { [weak self] factString in
            self?.factLabel.text = factString
        }
        
        viewModel.image.bind { [weak self] image in
            self?.catImageView.image = image
        }
        
        viewModel.factErrorHandling = { factError in
            print(factError.debugDescription)
        }
        
        viewModel.imageErrorHandling = { imageError in
            print(imageError.debugDescription)
        }
        viewModel.fetchData()
    }

    @objc private func tapped(gestureRecognizer: UITapGestureRecognizer) {
        viewModel.fetchData()
    }
}

