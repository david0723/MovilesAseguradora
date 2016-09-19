//
//  ViewController.swift
//  MovilesAseguradora
//
//  Created by David Santiago Chicaiza on 9/4/16.
//  Copyright © 2016 David Chicaiza. All rights reserved.
//

import UIKit

class MainViewController: UIViewController
{

    @IBOutlet weak var miPolizaButton: UIButton!
    @IBOutlet weak var MisContactosButton: UIButton!
    
    @IBOutlet weak var llamarButton: UIButton!
    @IBOutlet weak var emergenciaButt: UIButton!
    @IBAction func contactosBoton(sender: AnyObject)
    {
        
        
    }
    @IBAction func phoneCall(sender: AnyObject)
    {
        let phone = "tel://3015379821";
        let url:NSURL = NSURL(string:phone)!;
        UIApplication.sharedApplication().openURL(url);
    }

    @IBAction func showPoliza(sender: AnyObject)
    {
        self.alert()
    }
    @IBAction func enviarSms(sender: AnyObject)
    {
        
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        emergenciaButt.layer.cornerRadius = 5
        MisContactosButton.layer.cornerRadius = 5
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func alert()
    {
        let we = "Su poliza de seguro incluye: \n Seguro contra robo\n Seguro contra problemas mecanicos\n Seguro contra accidentes de transito."
        let alertController = UIAlertController(title: "Poliza", message: we, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
            print("OK")
        }
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }


}




class RegistrarseViewController: UIViewController
{
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}