//
//  NewGroupViewController.swift
//  MasterMenu
//
//  Created by NEOApp Tecnologia Ltda on 25/05/19.
//  Copyright © 2019 NEOApp Tecnologia Ltda. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class NewGroupViewController: UIViewController {
    
    @IBOutlet weak var txtGroupName: UITextField!
    
    @IBOutlet weak var txtShortDescription: UITextField!
    
    @IBOutlet weak var txtImageUrl: UITextField!
    
    weak var delegate: GroupListUpdater?
    
    let modelController = ModelController(modelName: "MasterMenu")

    var entity: MenuGroup? = nil
    
    @IBAction func btnSaveClick(_ sender: Any) {

        if(entity != nil){
            entity!.name = txtGroupName.text
            entity!.specification = txtShortDescription.text
            entity!.imageUrl = txtImageUrl.text
        }else{
            let newEntity = modelController.add(MenuGroup.self)
            newEntity?.name = txtGroupName.text
            newEntity?.specification = txtShortDescription.text
            newEntity?.imageUrl = txtImageUrl.text
        }
        
        modelController.save({
            self.delegate?.updateTableView()
        })
        
        navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(entity != nil){
            txtGroupName.text = entity!.name
            txtShortDescription.text = entity!.specification
            txtImageUrl.text = entity!.imageUrl
        }
    }
    
}
