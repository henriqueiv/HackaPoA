//
//  VolunteerProfileViewController.swift
//  HackaPoA
//
//  Created by Marcus Vinicius Kuquert on 06/11/15.
//  Copyright © 2015 HackaPoA. All rights reserved.
//

import UIKit

class VolunteerProfileViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageVIew: UIImageView!
    
    
    let sections = [["Administração", "Empreendedorismo", "Economia"], ["Marketing", "Desenho Gráfico", "Propaganda"],["Tecnologia", "Arduino", "Programação"]  ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.imageVIew.layer.cornerRadius = self.imageVIew.frame.height/2
        self.tableView.tableFooterView = UIView()
        self.tableView.registerNib(UINib(nibName: "ProfileTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "profileCell")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension VolunteerProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section][0]
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count - 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("profileCell")
        cell!.textLabel?.text = sections[indexPath.section][indexPath.row + 1]
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}