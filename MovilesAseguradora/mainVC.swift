//
//  ViewController.swift
//  MovilesAseguradora
//
//  Created by David Santiago Chicaiza on 9/4/16.
//  Copyright © 2016 David Chicaiza. All rights reserved.
//

import UIKit
import Foundation

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
//        emergenciaButt.layer.cornerRadius = 5
//        MisContactosButton.layer.cornerRadius = 5
        
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

    
    @IBOutlet weak var user_txt: UITextField!
    
    @IBOutlet weak var password_txt: UITextField!
    
    
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
    
        @IBAction func LogIn_btn(sender: UIButton)
    {
        print("login")
        let email = user_txt.text
        let pass = password_txt.text
        
//        let data = "secret_key=123&email=\(email)&password=\(pass)"
        
        let url = "https://nameless-earth-44333.herokuapp.com/moviles/login_json/"
        
        let json :Dictionary<String, AnyObject>= [ "secret_key":"123","email":email!,"password":pass!]
        var response: String?
        
        do
        {
            let jsonData  = try NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
            response = self.sendPost(url, args: jsonData)
            
        }
        catch
        {
            print("error bb")
        }
        
        print("LOGINBTN response: \(response)")
        print("LOGINBTN should be: All good mate :)")
        if response == "All good mate :)"
        {
            
            self.logIn()
            
        }
        else
        {
            self.alert()
        }
        
        
    }
    
    func sendPost(url: String, args: NSData) -> String
    {
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        var responseString = ""

        request.HTTPBody = args
        
        print(request.HTTPBody)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            responseString = String(data: data!, encoding: NSUTF8StringEncoding)!
            print("responseString = \(responseString)")
            
            
        }
        task.resume()
        
        print("SEND POST-> response String: \(responseString)")
        while responseString == ""
        {
            print("todavia no")
        }
        return responseString
    }
    
    func logIn()
    {
        print("transcision")
        
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("emergencias_app") as UIViewController
        
        self.presentViewController(viewController, animated: true, completion: nil)
        
    }
    
    func alert()
    {
        let we = "Su usuario o su contrasena son incorrectos"
        let alertController = UIAlertController(title: "Alerta", message: we, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
            print("OK")
        }
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
}

class myNavViewController: UINavigationController
{
    
}