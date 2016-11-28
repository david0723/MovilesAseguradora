//
//  ViewController.swift
//  MovilesAseguradora
//
//  Created by David Santiago Chicaiza on 9/4/16.
//  Copyright © 2016 David Chicaiza. All rights reserved.
//

import UIKit
import Foundation
import LocalAuthentication

class MainViewController: UIViewController
{

    @IBOutlet weak var miPolizaButton: UIButton!
    @IBOutlet weak var MisContactosButton: UIButton!
    
    @IBOutlet weak var llamarButton: UIButton!
    @IBOutlet weak var emergenciaButt: UIButton!
    
    @IBAction func salir(sender: AnyObject)
    {
        print("salir")
        
        let viewController:UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("myNavBar") as! UINavigationController
        viewController.popViewControllerAnimated(true)
    }

    
    
    @IBAction func logOut(sender: AnyObject)
    {
//        print("transcision")
//        
//        let viewController:UITabBarController = UIStoryboard(name: "myTabBar", bundle: nil).instantiateViewControllerWithIdentifier("emergencias_app") as! UITabBarController
//        
//        self.presentViewController(viewController, animated: true, completion: nil)
        
        
        
//        if let navController = self.navigationController
//        {
//            print("navbar")
//            navController.popViewControllerAnimated(true)
//        }
    }
    
    @IBAction func contactosBoton(sender: AnyObject)
    {
        
        
    }
    @IBAction func phoneCall(sender: AnyObject)
    {
        self.makePhoneCall()
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
        self.becomeFirstResponder()
        print("Screen brightness")
        print(UIScreen.mainScreen().brightness)
        // Do any additional setup after loading the view, typically from a nib.
//        emergenciaButt.layer.cornerRadius = 5
//        MisContactosButton.layer.cornerRadius = 5
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makePhoneCall()
    {
        let phone = "tel://3015379821";
        let url:NSURL = NSURL(string:phone)!;
        UIApplication.sharedApplication().openURL(url);
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

    override func canBecomeFirstResponder() -> Bool
    {
        return true
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?)
    {
        if(event!.subtype == UIEventSubtype.MotionShake)
        {
            self.makePhoneCall()
            
        }
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
    
    @IBAction func LogInGuest(sender: AnyObject)
    {
        print("log in guest")
        self.logIn()
    }
    
    @IBAction func TouchID(sender: AnyObject)
    {
        self.authWithTouchID()
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
        print("transcision LOGIN")
        
        let viewController:UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("myNavBar") as! UINavigationController
        
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
    
    func showAlert(msg: String, tittle: String)
    {
        let alertController = UIAlertController(title: tittle, message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
            print("OK")
        }
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool
    {
        if(text == "\n")
        {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    
    func authWithTouchID()
    {
        
        let authorization = LAContext()
        let authPolicy = LAPolicy.DeviceOwnerAuthenticationWithBiometrics
        
        
        let authorizationError: NSErrorPointer = nil
        
        
        if(authorization.canEvaluatePolicy(authPolicy, error: authorizationError)){
            // if device is touch id capable do something here
            
            authorization.evaluatePolicy(authPolicy, localizedReason: "Touch the fingerprint sensor", reply: {(success:Bool,error:NSError?) in
                
                
                if(success)
                {
//                    self.showAlert("Authentication Succesful", tittle: "Touch ID")
                    print("touching")
                    self.logIn();
                }
                else
                {
                    self.showAlert("Authentication Unsuccesful", tittle: "Touch ID")
                    print(error!.code)
                }

            })
        }
        else{
            // add alert
            print("Not Touch ID Capable")
        }
    }
}

class myNavViewController: UINavigationController
{
    
}

class registerViewController: UIViewController
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
    
    @IBOutlet weak var name_text: UITextField!
    @IBOutlet weak var email_text: UITextField!
    @IBOutlet weak var password_text: UITextField!
    
    @IBAction func register_Button(sender: AnyObject)
    {
        print("login")
        let email = email_text.text
        let pass = password_text.text
        let name = name_text.text
        
        //        let data = "secret_key=123&email=\(email)&password=\(pass)"
        
        let url = "https://nameless-earth-44333.herokuapp.com/moviles/register_json/"
        
        let json :Dictionary<String, AnyObject>= [ "secret_key":"123","email":email!,"password":pass!, "name":name!]
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
        print("transcision REGISTER")
        
        
        let viewController:UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("myNavBar") as! UINavigationController
        
        self.presentViewController(viewController, animated: true, completion: nil)
        
    }
    
    func alert()
    {
        let we = "error"
        let alertController = UIAlertController(title: "Alerta", message: we, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
            print("OK")
        }
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool
    {
        if(text == "\n")
        {
            textView.resignFirstResponder()
            return false
        }
        return true
    }

    
    
}