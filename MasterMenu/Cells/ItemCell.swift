//
//  ItemCell.swift
//  MasterMenu
//
//  Created by NEOApp Tecnologia Ltda on 26/05/19.
//  Copyright © 2019 NEOApp Tecnologia Ltda. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol ItemListUpdater: class { // the name of the protocol you can put any
    func updateTableView()
}

class ItemCell: UITableViewCell {
    

    @IBOutlet weak var imgLoader: ImageLoader!
    
    @IBOutlet weak var lblName: UILabel!
    
    
    @IBOutlet weak var lblSpecification: UILabel!
    
    @IBOutlet weak var lblPrice: UILabel!
    
    
    let modelController = ModelController(modelName: "MasterMenu")
    
    weak var delegate: ItemListUpdater?
    
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
