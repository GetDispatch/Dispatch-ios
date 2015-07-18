//
//  ViewController.swift
//  Dispatch
//
//  Created by Anuraag Yachamaneni on 5/16/15.
//  Copyright (c) 2015 Anuraag Yachamaneni. All rights reserved.
//

import UIKit
import MapKit
import AddressBook


class ViewController: UIViewController, MKMapViewDelegate {
    var addressBook: ABAddressBookRef?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        switch ABAddressBookGetAuthorizationStatus(){
        case .Authorized:
            println("Already authorized")
            createAddressBook()
            /* Access the address book */
        case .Denied:
            println("Denied access to address book")
            
        case .NotDetermined:
            createAddressBook()
            if let theBook: ABAddressBookRef = addressBook{
                ABAddressBookRequestAccessWithCompletion(theBook,
                    {(granted: Bool, error: CFError!) in
                        
                        if granted{
                            println("Access granted")
                        } else {
                            println("Access not granted")
                        }
                        
                })
            }
            
        case .Restricted:
            println("Access restricted")
            
        default:
            println("Other Problem")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func createAddressBook(){
        var error: Unmanaged<CFError>?
        addressBook = ABAddressBookCreateWithOptions(nil, &error).takeRetainedValue()
    }
    


}

