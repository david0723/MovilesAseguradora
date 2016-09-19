//
//  EmergenciaVC.swift
//  MovilesAseguradora
//
//  Created by David Santiago Chicaiza on 9/4/16.
//  Copyright © 2016 David Chicaiza. All rights reserved.
//

import UIKit

class EmergenciaViewController: UIViewController, UITableViewDataSource,UITableViewDelegate
{
    
 
    @IBOutlet weak var emergenciasTable: UITableView!
    
    var emergencias = [String]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.emergencias = app.sharedInstance.emergencias
        
        emergenciasTable.dataSource = self
        emergenciasTable.delegate = self
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return emergencias.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = emergenciasTable.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        cell.textLabel?.text = emergencias[indexPath.row]
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "emergenciaDetalle"
        {
            let i = emergenciasTable.indexPathForSelectedRow?.row
            
            let emergenciaEscogida = emergencias[i!]
            
            (segue.destinationViewController as! EmergenciaDetalleViewController).emergencia = emergenciaEscogida
        }
    }
    
}