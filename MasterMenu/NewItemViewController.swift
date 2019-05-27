//
//  NewItemViewController.swift
//  MasterMenu
//
//  Created by NEOApp Tecnologia Ltda on 26/05/19.
//  Copyright © 2019 NEOApp Tecnologia Ltda. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class NewItemViewController: UIViewController {
    
    @IBOutlet weak var txtItemName: UITextField!
    
    @IBOutlet weak var txtShortDescription: UITextField!
    
    @IBOutlet weak var txtImageUrl: UITextField!
    
    @IBOutlet weak var txtPrice: UITextField!
    
    
    weak var delegate: ItemListUpdater?
    
    let modelController = ModelController(modelName: "MasterMenu")
    
    var entity: MenuItem? = nil
    
    @IBAction func btnSaveClick(_ sender: Any) {
        
        if(entity != nil){
            entity!.name = txtItemName.text
            entity!.specification = txtShortDescription.text
            entity!.imageUrl = txtImageUrl.text
            entity!.price = txtPrice.text?.floatValue ?? 0
        }else{
            let newEntity = modelController.add(MenuItem.self)
            newEntity?.name = txtItemName.text
            newEntity?.specification = txtShortDescription.text
            newEntity?.imageUrl = txtImageUrl.text
            newEntity?.price = txtPrice.text?.floatValue ?? 0
        }
        
        modelController.save({
            self.delegate?.updateTableView()
        })
        
        navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(entity != nil){
            txtItemName.text = entity!.name
            txtShortDescription.text = entity!.specification
            txtImageUrl.text = entity!.imageUrl
            txtPrice.text = NSString(format: "%.2f", entity!.price) as String
        }
    }
}

extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
}
