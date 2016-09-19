//
//  MisContactos.swift
//  MovilesAseguradora
//
//  Created by David Santiago Chicaiza on 9/17/16.
//  Copyright © 2016 David Chicaiza. All rights reserved.
//

import UIKit
import RealmSwift



class MisContactosTableViewController: UITableViewController
{
    var contactos = [Contacto]()
    var telefono: String?
    var mail: String?
    
    @IBOutlet weak var plusButton: UIBarButtonItem!
    override func viewDidLoad()
    {
        
        //        Runs on background and then updates the table view
//        {self.initContacts()}<>{self.tableView.reloadData()};
        
        self.initContacts()
        self.tableView.reloadData()
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(MisContactosTableViewController.refrescarListaContactos(_:)),name:"refrescarListaContactos", object: nil)
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "miContacto"
        {
            let i = tableView.indexPathForSelectedRow?.row
            
            let con = contactos[i!]
            
            let vc = (segue.destinationViewController as! ContactoDetalleViewController)
            
            vc.nombre = con.nombre
            vc.telefono = con.telefono
            vc.email = con.email
            vc.miContacto = true
            
        }
    }
    
    func initContacts()
    {
        if let contcs = loadContacts()
        {
            contactos += contcs
        }
    }
    func refreshContacts()
    {
        if let contcs = loadContacts()
        {
            contactos = contcs
        }
    }
    
    func loadContacts() -> [Contacto]?
    {
        print("loading Contacts")

        let realm = try! Realm()
        
        
        let results = realm.objects(Contacto.self)
        print(results.count)
        
        return Array(results)
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return contactos.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath i: NSIndexPath) -> UITableViewCell
    {
        let contact: Contacto = contactos[i.row]
        
        let c: ContactoCell = tableView.dequeueReusableCellWithIdentifier("miContactoCell") as! ContactoCell
        
        c.initWithContact(contact)
        
        c.textLabel?.text = contact.nombre
        
        
        return c
    }
    
    func refrescarListaContactos(notification: NSNotification)
    {
        //load data here
        self.refreshContacts()
        self.tableView.reloadData()
    }
    
}