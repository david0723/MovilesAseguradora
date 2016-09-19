//
//  Message.swift
//  MovilesAseguradora
//
//  Created by David Santiago Chicaiza on 9/17/16.
//  Copyright © 2016 David Chicaiza. All rights reserved.
//

import UIKit
import MessageUI

class Message: UIViewController, MFMessageComposeViewControllerDelegate
{
    
    @IBOutlet weak var phoneNumber: UITextField!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    @IBAction func sendText(sender: UIButton)
    {
        if (MFMessageComposeViewController.canSendText())
        {
            let controller = MFMessageComposeViewController()
            controller.body = "Message Body"
            controller.recipients = [phoneNumber.text!]
            controller.messageComposeDelegate = self
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult)
    {
        //... handle sms screen actions
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
}
