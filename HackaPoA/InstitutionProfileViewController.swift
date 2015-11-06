//
//  InstitutionProfileViewController.swift
//  HackaPoA
//
//  Created by Henrique Valcanaia on 11/6/15.
//  Copyright © 2015 HackaPoA. All rights reserved.
//

import UIKit

class InstitutionProfileViewController: UIViewController {
    
    enum Section:Int{
        case Contact, InterestArea
    }
    
    enum Row:Int{
        case Address, Phone, Email
    }
    
    var shouldPresentBottomBar: Bool = false
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomBar: UIView!
    
    let contactCellClassName = "InstitutionProfileContactTableViewCell"
    let interestCellClassName = "InstitutionProfileInterestTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        let contactNib = UINib(nibName: contactCellClassName, bundle: NSBundle.mainBundle())
        tableView.registerNib(contactNib, forCellReuseIdentifier: contactCellClassName)
        
        let interestNib = UINib(nibName: interestCellClassName, bundle: NSBundle.mainBundle())
        tableView.registerNib(interestNib, forCellReuseIdentifier: interestCellClassName)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = imageView.bounds
        gradientLayer.colors = [UIColor.whiteColor(), UIColor.clearColor()]
        gradientLayer.startPoint = CGPointMake(0.5, 0.5)
        gradientLayer.endPoint = CGPointMake(1.0, 0.0)
        imageView.layer.addSublayer(gradientLayer)
        
        if shouldPresentBottomBar {
            self.tableView.contentInset = UIEdgeInsetsMake(0, 0, CGRectGetHeight(self.bottomBar.frame), 0)
        } else {
            self.bottomBar.hidden = true
        }
        
    }
    
    @IBAction func btnBackTouched(sender: UIButton) {
        self.navigationController!.popViewControllerAnimated(true)
    }

}

extension InstitutionProfileViewController: UITableViewDelegate{
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//        switch(indexPath.section){
//        case Section.Contact.rawValue:
//        case Section.InterestArea.rawValue:
//            
//        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
}

extension InstitutionProfileViewController: UITableViewDataSource{
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let string = (section == Section.Contact.rawValue) ? "Contato" : "Áreas de interesse"
        
        let view = UIView()
        
        view.backgroundColor = UIColor(red: 0xF6/255.0, green: 0xF8/255.0, blue: 0xFA/255.0, alpha: 1)
        
        let label = UILabel()
        label.frame = CGRectMake(15, 0, CGRectGetWidth(tableView.frame), 25);
        label.textColor = UIColor(red: 0x8F/255.0, green: 0x9F/255.0, blue: 0xA9/255.0, alpha: 1)
        label.font = UIFont.systemFontOfSize(10.0)
        label.text = string
        label.text = label.text!.uppercaseString
        
        view.addSubview(label)
        
        return view
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section{
        case Section.Contact.rawValue:
            let cell = tableView.dequeueReusableCellWithIdentifier(contactCellClassName) as! InstitutionProfileContactTableViewCell
            var text:String!
            var img:UIImage!
            switch indexPath.row{
            case Row.Address.rawValue:
                text = "Rua Marcílio Dias, 678 - Porto Alegre"
                img = UIImage(named: "cloud")

            case Row.Phone.rawValue:
                text = "(51) 9929-3781"
                img = UIImage(named: "phone")
                
            case Row.Email.rawValue:
                text = "hey@reddo.com"
                img = UIImage(named: "email")
                
            default:
                text = "default"
                img = UIImage(named: "cloud")
                
            }
            cell.textLabel?.text = text
            cell.textLabel?.textColor = UIColor ( red: 0.4667, green: 0.5137, blue: 0.549, alpha: 1.0 )
            cell.imageView?.image = img
            cell.imageView?.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.5, 0.5)
            cell.imageView?.contentMode = .Center
            
            return cell
            
        case Section.InterestArea.rawValue:
            let cell = tableView.dequeueReusableCellWithIdentifier(interestCellClassName)!
            var text:String!
            switch indexPath.row{
            case 0:
                text = "Empreendedorismo"
                
            case 1:
                text = "Economia"
                
            default:
                text = "Default"
                
            }
            
            cell.textLabel?.textColor = UIColor ( red: 0.4667, green: 0.5137, blue: 0.549, alpha: 1.0 )
            cell.textLabel?.text = text
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case Section.Contact.rawValue:
            return 3
            
        case Section.InterestArea.rawValue:
            return 2
            
        default:
            return 0
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
}
