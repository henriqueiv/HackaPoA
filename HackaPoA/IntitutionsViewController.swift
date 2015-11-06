//
//  IntitutionsViewController.swift
//  HackaPoA
//
//  Created by Henrique Valcanaia on 11/6/15.
//  Copyright © 2015 HackaPoA. All rights reserved.
//

import UIKit

class IntitutionsViewController: UIViewController {
    
    let institutions = ["EEEP Solon Tavares", "EMEF América"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad(){
        tableView.dataSource = self
        tableView.delegate = self
        
//        let headerView = UIView(frame: CGRectMake(0,0,tableView.frame.size.width,1))
//        headerView.backgroundColor = UIColor ( red: 0.4667, green: 0.5137, blue: 0.549, alpha: 1.0 )
//        tableView.tableHeaderView = headerView
        
//        let endpoint = "http://reddo-backend-hackaton.mybluemix.net/estaduais"
//        let url = NSURL(string: endpoint)!
//        let request = NSURLRequest(URL: url)
//        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response, data, error) -> Void in
//            do{
//                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: [NSJSONReadingOptions.MutableLeaves, NSJSONReadingOptions.MutableContainers])
//                if let results = json["results"] as? NSDictionary{
//                    if let records = results["records"] as? [NSDictionary]{
//                        print("records")
//                    }
//                }
////                print(json)
//            }catch let error{
//                print(error)
//            }
//        })
    }
}

extension IntitutionsViewController:UITableViewDelegate{
    
    
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
        
        cell.textLabel?.text = institutions[indexPath.row]
        cell.textLabel?.textColor = UIColor( red: 0.4667, green: 0.5137, blue: 0.549, alpha: 1.0 )
        
        return cell
    }
    
}
