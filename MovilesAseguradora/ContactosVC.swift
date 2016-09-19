//
//  ContactosVC.swift
//  MovilesAseguradora
//
//  Created by David Santiago Chicaiza on 9/6/16.
//  Copyright © 2016 David Chicaiza. All rights reserved.
//

import UIKit
import Contacts
import RealmSwift

prefix operator >< {}

prefix func >< (fun: ()->())
{
    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
    
    dispatch_async(dispatch_get_global_queue(priority, 0))
    {
        fun()
        dispatch_async(dispatch_get_main_queue())
        {
            // update some UI
        }
    }
}

infix operator <> {}

func <> (back: ()->(), front: ()->())
{
    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
    
    dispatch_async(dispatch_get_global_queue(priority, 0))
    {
        back()
        dispatch_async(dispatch_get_main_queue())
        {
            front()
        }
    }
}


class ContactosTableViewController: UITableViewController
{
    
    var cont = [CNContact]()
    var contactsClass = [Contacto]()
    var num: String?
    

     
    override func viewDidLoad()
    {
        
//        Runs on background and then updates the table view
        {self.initContacts()}<>{self.tableView.reloadData()};
        
//        Runs on the main thread        
//        self.initContacts()
//        self.tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "contactoDetalle"
        {
            print("Prepare for segue contacto Detalle")
            let i = tableView.indexPathForSelectedRow?.row
            
            let con = contactsClass[i!]
            print(con.nombre)
            
            let vc = (segue.destinationViewController as! ContactoDetalleViewController)
            
            vc.nombre = con.nombre
            
            vc.telefono = con.telefono
            
            vc.email = con.email
            
            vc.miContacto = false
            
            
        }
    }
    
    func getContactsClass()->[Contacto]
    {
        var contacs = [Contacto]()
        for c: CNContact in cont
        {
            var numeros: String?
            if (c.isKeyAvailable(CNContactPhoneNumbersKey))
            {
                for phoneNumber:CNLabeledValue in c.phoneNumbers
                {
                    let a = phoneNumber.value as! CNPhoneNumber
                    //                print("\(a.stringValue)")
                    numeros = a.stringValue
                    break
                }
                
            }
            
            let con = Contacto()
            con.email = "Mail de prueba"
            con.nombre = c.givenName
            con.telefono = numeros
            
            contacs.append(con)
        }
        return contacs
    }
    
    func initContacts()
    {
        cont = app.sharedInstance.contacts
        contactsClass = self.getContactsClass()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return cont.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath i: NSIndexPath) -> UITableViewCell
    {
        let contact: CNContact = cont[i.row]
        var numeros: String?
//        var correos = "No disponible"
        
        
        let c  = tableView.dequeueReusableCellWithIdentifier("contactoCell") as! ContactoCell
        
        c.textLabel?.text = contact.givenName
        
        
        if (contact.isKeyAvailable(CNContactPhoneNumbersKey))
        {
            for phoneNumber:CNLabeledValue in contact.phoneNumbers
            {
                let a = phoneNumber.value as! CNPhoneNumber
//                print("\(a.stringValue)")
                numeros = a.stringValue
                break
            }
            
        }
        
        c.telefono = numeros
        c.nombre = contact.givenName
        c.email = "mailmail"
        
        
        return c
    }
}