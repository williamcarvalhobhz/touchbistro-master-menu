//
//  ItemsViewController.swift
//  MasterMenu
//
//  Created by NEOApp Tecnologia Ltda on 26/05/19.
//  Copyright © 2019 NEOApp Tecnologia Ltda. All rights reserved.
//

import UIKit
import CoreData

class ItemsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ItemListUpdater {
    
    @IBOutlet weak var tblView: UITableView!
    
    @IBOutlet weak var btnNewGroup: UIButton!
    
    let modelController = ModelController(modelName: "MasterMenu")
    
    let reuseIdentifier:String = "itemCell"
    
    var dataSource = [MenuItem]()
    
    
    @IBAction func btnNewGroupClick(_ sender: Any) {
        
        let vw:NewItemViewController = self.storyboard!.instantiateViewController(withIdentifier: "idNewItemViewController") as! NewItemViewController
        
        vw.entity = nil
        
        vw.delegate = self
        
        self.navigationController?.pushViewController(vw, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.dataSource = self
        tblView.delegate = self
        
        updateTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateTableView()
        
        // Hide the Navigation Bar
        //self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        btnNewGroup.layer.cornerRadius = 35
    }
    
    func updateTableView() {
        
        dataSource = modelController.fetch(MenuItem.self)!
        self.tblView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the Navigation Bar
        //self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! ItemCell
        
        cell.delegate = self
        
        tableView.rowHeight = 100
        
        let entity = dataSource[indexPath.row]
        
        cell.objectID = entity.objectID
        cell.lblName.text = entity.name
        cell.lblSpecification.text = entity.specification
        
        cell.lblPrice.text = "$" + (NSString(format: "%.2f", entity.price) as String)
        
        if entity.imageUrl != nil {
            cell.imgLoader.loadImage(url: entity.imageUrl!)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vw:NewItemViewController = (self.storyboard!.instantiateViewController(withIdentifier: "idNewItemViewController") as? NewItemViewController)!
        
        vw.entity = dataSource[indexPath.row]
        
        self.navigationController?.pushViewController(vw, animated: true)
    }
    
}
