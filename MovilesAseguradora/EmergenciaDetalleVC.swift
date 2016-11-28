//
//  EmergenciaDetalleVC.swift
//  MovilesAseguradora
//
//  Created by David Santiago Chicaiza on 9/4/16.
//  Copyright © 2016 David Chicaiza. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import MessageUI
import RealmSwift
import MobileCoreServices

class EmergenciaDetalleViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, MFMessageComposeViewControllerDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    
    var img : UIImage?
    
    
    @IBOutlet weak var imageOnView: UIImageView!
    var emergencia: String?
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var titulo: UINavigationItem!
    
    @IBOutlet weak var DescripcionTextView: UITextView!
    let l = CLLocationManager()
    var pin = false
    var latitude: String?
    var longitud: String?
    
    @IBAction func contactarAseguradora(sender: AnyObject)
    {
        if let p = punto
        {
            let lat = String(p.coordinate.latitude)
            let long = String(p.coordinate.longitude)
            
            let coord = lat + ", " + long
            
            alert(coord)
        }
        alert("---")
    }
    
    override func viewDidLoad()
    {
        if (UIScreen.mainScreen().brightness < 0.2)
        {
            self.view.backgroundColor = UIColor.blackColor()
        }
        
        
        super.viewDidLoad()
        
        let borderColor = UIColor(colorLiteralRed: 255, green: 255, blue: 255, alpha: 1)
        
        DescripcionTextView.layer.borderColor = borderColor.CGColor
        
        self.DescripcionTextView.delegate = self
        self.l.delegate = self
        self.l.desiredAccuracy = kCLLocationAccuracyBest
        self.l.requestWhenInUseAuthorization()
        self.l.startUpdatingLocation()
        self.mapView.showsUserLocation = true
        
        let lat_double = ((self.l.location?.coordinate.latitude)! as Double)
        
        let lon_double = ((self.l.location?.coordinate.longitude)! as Double)
        
        
        print("lat double: \(lat_double)")
        print("lon double: \(lon_double)")
        
        let lat_string = "\(lat_double)"
        let lon_string = "\(lon_double)"
        
        print("lat string: \(lat_string)")
        print("lon string: \(lon_string)")
        
        self.latitude = lat_string
        
        
        self.longitud = lon_string
        
        
        
        if let label = emergencia
        {
            titulo.title = label
            
            var descripcion = "Tuve una emergencia de tipo " + label
            
            descripcion += "\n"
            descripcion += "En \(self.getJSON(latitude!, long: longitud!))"
            descripcion += "\n"
            
            DescripcionTextView.text = descripcion
        }
        print("view did load")
//        print(latitude)
//        print(latitude!)
        
        
        
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(EmergenciaDetalleViewController.action(_:)))
        longPress.minimumPressDuration = 1.0
        mapView.addGestureRecognizer(longPress)

    }
    var punto: MKPointAnnotation?
    
    func openCamera()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!)
    {
        imageOnView.contentMode = .ScaleAspectFit
        imageOnView.image = image
        self.img = image
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    func action(gestureRecognizer:UIGestureRecognizer)
    {
        let touchPoint = gestureRecognizer.locationInView(self.mapView)
        let newCoord:CLLocationCoordinate2D = mapView.convertPoint(touchPoint, toCoordinateFromView: self.mapView)
        
        if let p = punto
        {
            mapView.removeAnnotation(punto!)
            punto!.coordinate = newCoord
            punto!.title = "Locación actual"
            //        newAnotation.subtitle = "New Subtitle"
            mapView.addAnnotation(punto!)
            
        }
        else
        {
            punto = MKPointAnnotation()
            punto!.coordinate = newCoord
            punto!.title = "Locación actual"
            //        newAnotation.subtitle = "New Subtitle"
            mapView.addAnnotation(punto!)
        }
        
        
    }
    
    @IBAction func sendHelp(sender: AnyObject)
    {
        sendSMS(DescripcionTextView.text)

    }
    @IBAction func TakePicture(sender: AnyObject)
    {
        self.openCamera()
    }
    
    func getRecipients() -> [String]
    {
        let realm = try! Realm()
        var resp = [String]()
        
        let results = realm.objects(Contacto.self)
        
        for r in results
        {
            resp += [r.telefono!]
        }
        return resp
    }
    
    func sendSMS(mensaje: String)
    {
        if (MFMessageComposeViewController.canSendText())
        {
            let controller = MFMessageComposeViewController()
            controller.body = mensaje
            controller.recipients = getRecipients()
            controller.messageComposeDelegate = self
            if let i = self.img
            {
                controller.addAttachmentData(UIImagePNGRepresentation(i)!, typeIdentifier: kUTTypePNG as String, filename: "image.png")
                
            }
            
            
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last
        
        latitude = "\(location?.coordinate.latitude)"
        longitud = "\(location?.coordinate.longitude)"
        
//        print(latitude)
//        print(longitud)
        
        let center = CLLocationCoordinate2D(latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!)
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        
        self.mapView.setRegion(region, animated: true)
        
        self.l.stopUpdatingLocation()
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult)
    {
        //... handle sms screen actions
        self.dismissViewControllerAnimated(true, completion: nil)
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
    
    func alert(m: String)
    {
        let mensaje = "El mensaje a sido enviado a la agencia. Coordenadas: " + m
        let alertController = UIAlertController(title: "Emergencia", message: mensaje , preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
            print("OK")
        }
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func sendTextMessageButtonTapped(sender: UIButton)
    {
        let urlString = DescripcionTextView.text
        let urlStringEncoded = urlString.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
        let url  = NSURL(string: "whatsapp://send?text=\(urlStringEncoded!)")
        
        if UIApplication.sharedApplication().canOpenURL(url!)
        {
            UIApplication.sharedApplication().openURL(url!)
        }
        else
        {
            alert("No se pudo :p")
        }
        
    }
    
    func getJSON(lat: String, long: String) -> String
    {

        let url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(lat),\(long)&key=AIzaSyDmi_hjlSBcxwXPXznvUG0RAPp5k9awf2c"

        print("url: \(url)")
        let jsonData = NSData(contentsOfURL: NSURL(string: url)!)!
        
        do
        {
            let json = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments)
            print(json)
            
            return (json["results"]!![0]["formatted_address"] as? String)!
            

            
//            if let results = json["results"] as? [[String: AnyObject]]
//            {
//                print("results 0")
//                print(results[0])
//
//                if let a = results[]
//            }
//            else
//            {
//                print("pailas")
//            }
            
        }
        catch
        {
            
        }
        return "No address Av"
    }
    
    func makeHTTPGetRequest(path: String)
    {
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
//            if let jsonData = data
//            {
//                
//            }
//            else
//            {
//
//            }
        })
        task.resume()
    }
}
