//
//  ListaVoluntariosViewController.swift
//  HackaPoA
//
//  Created by Henrique Valcanaia on 11/6/15.
//  Copyright © 2015 HackaPoA. All rights reserved.
//

import UIKit

class ListaVoluntariosViewController: UIViewController {

    var itemList = [IBMDataObject]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        SVProgressHUD.showWithStatus("Carregando voluntarios")
        let qry = IBMQuery(forClass: "Voluntarios")
        qry.find().continueWithBlock{ task in
            if((task.error()) != nil) {
                print("listItems failed with error: %@", task.error)
            } else {
                self.itemList = []
                if let result = task.result() as? [IBMDataObject] {
                    self.itemList = result
                }
                self.tableView.reloadData()
                SVProgressHUD.dismiss()
            }
            return nil
        }
    }
    
}

extension ListaVoluntariosViewController:UITableViewDelegate{
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45
    }
    
}

extension ListaVoluntariosViewController:UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "VoluntarioCell")
        
        cell.textLabel?.text = itemList[indexPath.row].objectForKey("nome") as? String
        cell.detailTextLabel?.text = itemList[indexPath.row].objectForKey("curso") as? String
        
        return cell
    }
    
}