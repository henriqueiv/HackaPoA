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
    @IBOutlet weak var bottomBar: UIView!
    
    let sections = [["Administração", "Empreendedorismo", "Economia"], ["Marketing", "Desenho Gráfico", "Propaganda"],["Tecnologia", "Arduino", "Programação"]  ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.imageVIew.layer.cornerRadius = self.imageVIew.frame.height/2
        self.tableView.tableFooterView = UIView()
        self.tableView.registerNib(UINib(nibName: "ProfileTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "profileCell")
        // Do any additional setup after loading the view.
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, CGRectGetHeight(self.bottomBar.frame), 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnInstituicoesTouched(sender: UIButton) {
        
        let vc = IntitutionsViewController()
        self.navigationController!.setViewControllers([vc], animated: false)
        
    }
    
}


extension VolunteerProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25;
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        
        view.backgroundColor = UIColor(red: 0xF6/255.0, green: 0xF8/255.0, blue: 0xFA/255.0, alpha: 1)
        
        let label = UILabel()
        label.frame = CGRectMake(15, 0, CGRectGetWidth(tableView.frame), 25);
        label.textColor = UIColor(red: 0x8F/255.0, green: 0x9F/255.0, blue: 0xA9/255.0, alpha: 1)
        label.font = UIFont.systemFontOfSize(10.0)
        label.text = sections[section][0]
        label.text = label.text!.uppercaseString

        view.addSubview(label)
        
        return view
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
        let vc = IntitutionsViewController()
        vc.title = sections[indexPath.section][indexPath.row + 1]
        
        self.navigationController!.setViewControllers([vc], animated: false)
    }
}