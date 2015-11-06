//
//  ViewController.swift
//  HackaPoA
//
//  Created by Henrique Valcanaia on 11/5/15.
//  Copyright © 2015 HackaPoA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func gotoView(sender: UIButton) {
//        let view = UIViewController(nibName: "VolunteerProfileViewController", bundle: NSBundle.mainBundle())
        self.presentViewController(VolunteerProfileViewController(), animated: true, completion: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

