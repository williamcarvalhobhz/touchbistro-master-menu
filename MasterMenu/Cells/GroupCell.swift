//
//  GroupCell.swift
//  MasterMenu
//
//  Created by NEOApp Tecnologia Ltda on 25/05/19.
//  Copyright © 2019 NEOApp Tecnologia Ltda. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol GroupListUpdater: class { // the name of the protocol you can put any
    func updateTableView()
}

class GroupCell: UITableViewCell {

    
    @IBOutlet weak var imgLoader: ImageLoader!
    
    @IBOutlet weak var lblName: UILabel!
    
    
    @IBOutlet weak var lblSpecification: UILabel!
    
    let modelController = ModelController(modelName: "MasterMenu")
    
    weak var delegate: GroupListUpdater?
    
    var objectID = NSManagedObjectID()

    @IBAction func btnDeleteClick(_ sender: Any) {
        
        modelController.delete(by: objectID)

        modelController.save({
            self.delegate?.updateTableView()
        })

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
