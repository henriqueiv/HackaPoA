//
//  InstitutionProfileViewController.swift
//  HackaPoA
//
//  Created by Henrique Valcanaia on 11/6/15.
//  Copyright © 2015 HackaPoA. All rights reserved.
//

import UIKit
import MapKit
import MessageUI

class InstitutionProfileViewController: UIViewController {
    
    enum Section:Int{
        case Contact, InterestArea
    }
    
    enum Row:Int{
        case Address, Phone, Email
    }
    
    var shouldPresentBottomBar: Bool = false
    var isInstitution = false
    var institution:IBMDataObject!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomBar: UIView!
    @IBOutlet weak var btnRight: UIButton!
    
    @IBOutlet weak var institutionNameLabel: UILabel!
    let contactCellClassName = "InstitutionProfileContactTableViewCell"
    let interestCellClassName = "InstitutionProfileInterestTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if institution != nil{
            institutionNameLabel.text = (institution.objectForKey("escola") as! String).capitalizedString
        }else{
            institutionNameLabel.text = "EEEF América"
        }
        
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
            if isInstitution{
                btnRight.setTitle("Voluntários", forState: UIControlState.Normal)
            }else{
                btnRight.setTitle("Instituições", forState: UIControlState.Normal)
            }
        } else {
            self.bottomBar.hidden = true
        }
        
    }
    
    @IBAction func btnBackTouched(sender: UIButton) {
        self.navigationController!.popViewControllerAnimated(true)
    }
    
    
    @IBAction func lista(sender: AnyObject) {
        if isInstitution{
            print("lista voluntarios")
        }
    }
    
    
}

extension InstitutionProfileViewController: UITableViewDelegate{
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        switch indexPath.section{
        case Section.Contact.rawValue:
            switch indexPath.row{
            case Row.Address.rawValue:
                let geoCoder = CLGeocoder()
                let addressString = institution.objectForKey("endereco") as! String
                
                geoCoder.geocodeAddressString(addressString, completionHandler: { (placemarks: [CLPlacemark]?, error:NSError?) -> Void in
                    if error != nil {
                        SVProgressHUD.showErrorWithStatus("Erro obtendo localização! \(error!.localizedDescription)")
                    } else if placemarks!.count > 0 {
                        let placemark = placemarks![0]
                        let location = placemark.location
                        let latitute:CLLocationDegrees = (placemark.location?.coordinate.latitude)!
                        let longitute:CLLocationDegrees = (placemark.location?.coordinate.longitude)!
                        let regionDistance:CLLocationDistance = 100
                        let coordinates = CLLocationCoordinate2DMake(latitute, longitute)
                        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
                        let options = [ MKLaunchOptionsMapCenterKey: NSValue(MKCoordinate: regionSpan.center),
                            MKLaunchOptionsMapSpanKey: NSValue(MKCoordinateSpan: regionSpan.span) ]
                        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: (location?.coordinate)!, addressDictionary: nil))
                        mapItem.name = addressString
                        mapItem.openInMapsWithLaunchOptions(options)
                    }
                })
                
                
            case Row.Phone.rawValue:
                if institution != nil{
                    let stringArray = (institution.objectForKey("telefone") as! String).componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet)
                    let newString = stringArray.joinWithSeparator("")
                    
                    let url: NSURL = NSURL(string: NSString(format: "tel://%@", newString as String) as String)!
                    UIApplication.sharedApplication().openURL(url)
                }
                
            case Row.Email.rawValue:
                if institution != nil{
                    if MFMailComposeViewController.canSendMail() {
                        SVProgressHUD.showWithStatus(NSLocalizedString("Enviando o email...",comment:""), maskType: SVProgressHUDMaskType.Gradient)
                        let mailComposer = MFMailComposeViewController()
                        mailComposer.mailComposeDelegate = self
                        mailComposer.setToRecipients([institution.objectForKey("email") as! String])
                        mailComposer.setSubject(NSLocalizedString("Reddo - Voluntário interessado :)",comment:""))
                        mailComposer.setMessageBody(NSLocalizedString("Oi, meu nome é Henrique e estou interessado em ministrar um curso nesta insituição.", comment:""), isHTML: true)
                        presentViewController(mailComposer, animated: true, completion: nil)
                        SVProgressHUD.dismiss()
                    }else{
                        SVProgressHUD.showErrorWithStatus(NSLocalizedString("Enable to send email!", comment:""), maskType: SVProgressHUDMaskType.Gradient)
                    }
                }
                
            default:
                print("")
                
            }
            
        case Section.InterestArea.rawValue:
            print("")
            
        default:
            print("")
        }
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
                if institution != nil{
                    text = (institution.objectForKey("endereco") as! String).capitalizedString
                }else{
                    text = "Rua ficticia"
                }
                img = UIImage(named: "cloud")
                
            case Row.Phone.rawValue:
                if institution != nil{
                    text = institution.objectForKey("telefone") as! String
                }else{
                    text = "(51)8295-3582"
                }
                img = UIImage(named: "phone")
                
            case Row.Email.rawValue:
                if institution != nil{
                    text = institution.objectForKey("email") as! String
                }else{
                    text = "contato@instituicao.edu.br"
                }
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


// MARK: - MFMailComposeViewControllerDelegate
extension InstitutionProfileViewController:MFMailComposeViewControllerDelegate{
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        switch (result.rawValue) {
        case MFMailComposeResultCancelled.rawValue:
            SVProgressHUD.showInfoWithStatus(NSLocalizedString("Email cancelado", comment:""), maskType: SVProgressHUDMaskType.Gradient)
            break;
            
        case MFMailComposeResultSaved.rawValue:
            SVProgressHUD.showInfoWithStatus(NSLocalizedString("Email salvo", comment:""), maskType: SVProgressHUDMaskType.Gradient)
            break;
            
        case MFMailComposeResultSent.rawValue:
            SVProgressHUD.showSuccessWithStatus(NSLocalizedString("Email enviado!", comment: ""), maskType: SVProgressHUDMaskType.Gradient)
            break;
            
        case MFMailComposeResultFailed.rawValue:
            SVProgressHUD.showSuccessWithStatus(String(format:NSLocalizedString("Erro ao enviar o email! %@", comment:""), (error?.localizedDescription)!), maskType: SVProgressHUDMaskType.Gradient)
            break;
            
        default:
            break;
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}