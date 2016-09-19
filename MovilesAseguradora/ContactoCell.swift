//
//  ContactoCell.swift
//  MovilesAseguradora
//
//  Created by David Santiago Chicaiza on 9/17/16.
//  Copyright © 2016 David Chicaiza. All rights reserved.
//

import UIKit

class ContactoCell: UITableViewCell
{
    var nombre: String?
    var telefono: String?
    var email: String?
    
    func initWithContact(contacto: Contacto)
    {
        self.nombre = contacto.nombre
        self.telefono = contacto.telefono
        self.email = contacto.email
    }
    
    func toContact()-> Contacto
    {
        let c = Contacto(value: ["nombre":nombre!,"telefono": telefono!, "email": email!])
        return c
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}