//
//  HomeViewController.swift
//  HackaPoA
//
//  Created by William Hass on 11/6/15.
//  Copyright © 2015 HackaPoA. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func btnAlunoPressed(sender: UIButton) {
        
    }
    
    @IBAction func btnInstPressed(sender: UIButton) {
        let vc = InstitutionProfileViewController()
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnVolPressed(sender: UIButton) {
        let vc = VolunteerProfileViewController()
        self.navigationController!.pushViewController(vc, animated: true)
    }

}
