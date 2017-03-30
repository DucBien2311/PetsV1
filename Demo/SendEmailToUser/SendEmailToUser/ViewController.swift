//
//  ViewController.swift
//  SendEmailToUser
//
//  Created by khacviet on 2/9/17.
//  Copyright © 2017 khacviet. All rights reserved.


import UIKit
import MessageUI
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func sendEmailButtonTapped(sender: AnyObject) {
                print("A")
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
                        print("true")
        } else {
            self.showSendMailErrorAlert()
                        print("False")
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
                print("B")
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["im.dinhkhacviet@gmail.com"])
        mailComposerVC.setSubject("Chủ Đề...")
        mailComposerVC.setMessageBody("Nội Dung...", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email",
                                             message: "Your device could not send e-mail.  Please check e-mail configuration and try again.",
                                             delegate: self,
                                             cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
}

//     MARK: MFMailComposeViewControllerDelegate

extension ViewController: MFMailComposeViewControllerDelegate
{
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult,
                               error: Error?) {
        switch result
        {
        case MFMailComposeResult.sent:
            let sendMailFinalAlert = UIAlertView(title: "Final",
                                                 message: "...",
                                                 delegate: self,
                                                 cancelButtonTitle: "OK")
            sendMailFinalAlert.show()
        case MFMailComposeResult.cancelled:
            let sendMailFinalAlert = UIAlertView(title: "Cancel",
                                                 message: "...",
                                                 delegate: self,
                                                 cancelButtonTitle: "OK")
            sendMailFinalAlert.show()
        case MFMailComposeResult.saved:
            let sendMailFinalAlert = UIAlertView(title: "Save",
                                                 message: "...",
                                                 delegate: self,
                                                 cancelButtonTitle: "OK")
            sendMailFinalAlert.show()
        case MFMailComposeResult.failed:
            let sendMailFinalAlert = UIAlertView(title: "Fail",
                                                 message: "...",
                                                 delegate: self,
                                                 cancelButtonTitle: "OK")
            sendMailFinalAlert.show()
        default:
            break
        }
        controller.dismiss(animated: true, completion: nil)
    }
}
