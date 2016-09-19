//
//  app.swift
//  MovilesAseguradora
//
//  Created by David Santiago Chicaiza on 9/4/16.
//  Copyright © 2016 David Chicaiza. All rights reserved.
//

import Foundation
import Contacts

class app: NSObject
{
    lazy var contacts: [CNContact] =
        {
        let contactStore = CNContactStore()
        let keysToFetch = [
            CNContactFormatter.descriptorForRequiredKeysForStyle(.FullName),
            CNContactEmailAddressesKey,
            CNContactPhoneNumbersKey,
            CNContactImageDataAvailableKey,
            CNContactThumbnailImageDataKey,
            CNContactPhoneNumbersKey]
        
        // Get all the containers
        var allContainers: [CNContainer] = []
        do
        {
            allContainers = try contactStore.containersMatchingPredicate(nil)
        }
        catch
        {
            print("Error fetching containers")
        }
        
        var results: [CNContact] = []
        
        // Iterate all containers and append their contacts to our results array
        for container in allContainers
        {
            let fetchPredicate = CNContact.predicateForContactsInContainerWithIdentifier(container.identifier)
            
            do
            {
                let containerResults = try contactStore.unifiedContactsMatchingPredicate(fetchPredicate, keysToFetch: keysToFetch)
                results.appendContentsOf(containerResults)
            }
            catch
            {
                print("Error fetching results for container")
            }
        }
        
        return results
    }()
    
    
    
    var contactos = [CNContact]()
    class var sharedInstance: app
    {
        struct Singleton
        {
            static let instance = app()
        }
        return Singleton.instance
    }
    
    
    var emergencias = ["Me robaron", "Me varé", "Me Chocaron", "Problema mecanico no determinado","Bateria Descargada","Llanta pinchada", "Accidente de transito leve", "Accidente de transito grave", "Recalentamiento del motor"]
    
    func getContacts()
    {
        let store = CNContactStore()
        
        if CNContactStore.authorizationStatusForEntityType(.Contacts) == .NotDetermined
        {
            store.requestAccessForEntityType(.Contacts, completionHandler: { (authorized: Bool, error: NSError?) -> Void in
                if authorized
                {
                    self.retrieveContactsWithStore(store)
                }
            })
        }
        else if CNContactStore.authorizationStatusForEntityType(.Contacts) == .Authorized
        {
            self.retrieveContactsWithStore(store)
        }
        
    }
    
    
    func retrieveContactsWithStore(store: CNContactStore)
    {
        do
        {
            
            let groups = try store.groupsMatchingPredicate(nil)
            let predicate = CNContact.predicateForContactsInGroupWithIdentifier(groups[0].identifier)
            //let predicate = CNContact.predicateForContactsMatchingName("John")
            let keysToFetch = [CNContactFormatter.descriptorForRequiredKeysForStyle(.FullName), CNContactEmailAddressesKey]
            
            contactos = try store.unifiedContactsMatchingPredicate(predicate, keysToFetch: keysToFetch)
        }
        catch
        {
            print(error)
        }
    }
    

}