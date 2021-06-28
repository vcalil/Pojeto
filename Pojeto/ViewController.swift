//
//  ViewController.swift
//  Pojeto
//
//  Created by Galil on 28/06/21.
//

import UIKit

class LabelViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = loadTitle()
        // Do any additional setup after loading the view.
        
    }

    func loadTitle() -> String {
        return "boludo"
    }

}

