//
//  IntitutionsViewController.swift
//  HackaPoA
//
//  Created by Henrique Valcanaia on 11/6/15.
//  Copyright © 2015 HackaPoA. All rights reserved.
//

import UIKit

class IntitutionsViewController: UIViewController {
    
    var institutions = [IBMDataObject]()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func btnMeuProfileTouched(sender: UIButton) {
        
        let vc = VolunteerProfileViewController()
        self.navigationController!.setViewControllers([vc], animated: false)
        
    }
    
    override func viewDidLoad(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        
        let test = Test()
        SVProgressHUD.showWithStatus("Carregando instituições")
        test.listItems {
            self.institutions = test.itemList.sort({ (this, that) -> Bool in
                (this.objectForKey("escola") as! String).localizedCaseInsensitiveCompare(that.objectForKey("escola") as! String) == NSComparisonResult.OrderedAscending
            })
            self.tableView.reloadData()
            SVProgressHUD.dismiss()
        }
    }
}

extension IntitutionsViewController:UITableViewDelegate{
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let vc = InstitutionProfileViewController()
        vc.institution = self.institutions[indexPath.row]
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
}

extension IntitutionsViewController:UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return institutions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "InstitutionCell")
        
        let escola = institutions[indexPath.row].objectForKey("escola") as! String
        cell.textLabel?.text = escola.capitalizedString
        cell.textLabel?.textColor = UIColor( red: 0.4667, green: 0.5137, blue: 0.549, alpha: 1.0 )
        
        cell.accessoryType = .DisclosureIndicator
        
        return cell
    }
    
}
