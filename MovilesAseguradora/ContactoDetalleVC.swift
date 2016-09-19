//
//  ContactoDetalleVC.swift
//  MovilesAseguradora
//
//  Created by David Santiago Chicaiza on 9/7/16.
//  Copyright © 2016 David Chicaiza. All rights reserved.
//

import UIKit
import RealmSwift

class ContactoDetalleViewController: UIViewController
{
    var nombre: String?
    var telefono: String?
    var email: String?
    
    var miContacto:Bool?
    
    @IBOutlet weak var correoLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var contactoTitulo: UINavigationItem!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBAction func deleteButton(sender: AnyObject)
    {
        let realm = try! Realm()
        
        var x = "nombre = '"+contactoTitulo.title!
        x+="'"
        
        let o = realm.objects(Contacto.self).filter(x)
        realm.beginWrite()
        
        for i in Array(o)
        {
            realm.delete(i)
        }
        
        try! realm.commitWrite()
        
        alert("eliminado")
        
        NSNotificationCenter.defaultCenter().postNotificationName("refrescarListaContactos", object: nil)
        
    }
    
    @IBAction func agregarContactoButton(sender: AnyObject)
    {
        saveContact()
        alert("agregado")
        
        NSNotificationCenter.defaultCenter().postNotificationName("refrescarListaContactos", object: nil)
    }
    
    func saveContact()
    {
        let c = Contacto(value: ["nombre": nombre!,"telefono": telefono!, "email": email!])
        
        let realm = try! Realm()
        realm.beginWrite()
        realm.add(c)
        try! realm.commitWrite()
    }
    
    override func viewDidLoad()
    {
        
        if let label = nombre
        {
            contactoTitulo.title = label
        }
        else
        {
            contactoTitulo.title = "nombre no disponible"
        }
        
        if let tel = telefono
        {
            numberLabel.text = tel
        }
        else
        {
            numberLabel.text = "telefono no dispnible"
        }
        
        if let mail = email
        {
            correoLabel.text = mail
        }
        else
        {
            correoLabel.text = "Correo no disponible"
    
        }
        if let b = miContacto
        {
            if !b
            {
                deleteButton.removeFromSuperview()
            }
        }
        
    }
    func alert(m: String )
    {
        let we = "El contacto ha sido " + m
        let alertController = UIAlertController(title: "Contacto", message: we, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
            print("OK")
        }
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}
