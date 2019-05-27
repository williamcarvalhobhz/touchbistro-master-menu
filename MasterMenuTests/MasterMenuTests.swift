//
//  MasterMenuTests.swift
//  MasterMenuTests
//
//  Created by NEOApp Tecnologia Ltda on 25/05/19.
//  Copyright © 2019 NEOApp Tecnologia Ltda. All rights reserved.
//

import XCTest
@testable import MasterMenu

class MasterMenuTests: XCTestCase {
    
    var modelController: ModelController?

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        modelController = ModelController(modelName: "MasterMenu")
    }
    
    func testAddMenuGroup() {
        let name = "Waffles"
        let specification = "Great waffles to enjoy!"
        let imageUrl = "https://www.graceandgoodeats.com/wp-content/uploads/2018/09/homemade-waffles.jpg"
        
        let newMenuGroup = modelController!.add(MenuGroup.self)
        XCTAssertNotNil(newMenuGroup)
        
        newMenuGroup?.name = name
        newMenuGroup?.specification = specification
        newMenuGroup?.imageUrl = imageUrl
        XCTAssertEqual(name, newMenuGroup?.name, "Waffles")
        XCTAssertEqual(specification, newMenuGroup?.specification, "Great waffles to enjoy!")
        XCTAssertEqual(imageUrl, newMenuGroup?.imageUrl, "https://www.graceandgoodeats.com/wp-content/uploads/2018/09/homemade-waffles.jpg")
    }

    
    func testTotalMenuGroup() {
        
        let newMenuGroup = modelController!.add(MenuGroup.self)
        
        newMenuGroup?.name = "Waffles"
        newMenuGroup?.specification = "Great waffles to enjoy!"
        newMenuGroup?.imageUrl = "https://www.graceandgoodeats.com/wp-content/uploads/2018/09/homemade-waffles.jpg"
        
        let total = modelController!.total(MenuGroup.self)
        XCTAssertGreaterThan(total, 0)
    }
    
    func testFetchMenuGroup() {
        
        let name = "Waffles1"
        let newMenuGroup = modelController!.add(MenuGroup.self)
        newMenuGroup?.name = "Waffles1"
        newMenuGroup?.specification = "Great waffles to enjoy!"
        newMenuGroup?.imageUrl = "https://www.graceandgoodeats.com/wp-content/uploads/2018/09/homemade-waffles.jpg"
        
        let predicate = NSPredicate(format: "name LIKE %@", name)
        let fetched = modelController!.fetch(MenuGroup.self, predicate: predicate)
        
        guard let fetchedMenuGroup = fetched?.last else {
            XCTAssertNotNil(fetched)
            return
        }
        
        XCTAssertEqual(fetchedMenuGroup, newMenuGroup, "The fetched MenuGroup does not equal the created MenuGroup!")
    }
    
    func testDeleteMenuGroup() {
        
        //Test for deletion by objectID...
        let expectation1 = XCTestExpectation(description: "Delete core data object by objectID")
        
        let newMenuGroup = modelController!.add(MenuGroup.self)
        var total = modelController!.total(MenuGroup.self)
        
        modelController!.delete(by: newMenuGroup!.objectID) {
            
            let deletedTotal = self.modelController!.total(MenuGroup.self)
            XCTAssertLessThan(deletedTotal, total)
            expectation1.fulfill()
        }
        
        //Test for deletion by predicate...
        let expectation2 = XCTestExpectation(description: "Delete core data object by predicate")
        
        let outdatedMenuGroup = modelController!.add(MenuGroup.self)
        let name = "Waffles"
        outdatedMenuGroup?.name = name
        
        total = modelController!.total(MenuGroup.self)
        let predicate = NSPredicate(format: "name LIKE %@", name)
        
        modelController!.delete(MenuGroup.self, predicate: predicate) {
            
            let deletedTotal = self.modelController!.total(MenuGroup.self)
            XCTAssertLessThan(deletedTotal, total)
            expectation2.fulfill()
        }
        
        wait(for: [expectation1, expectation2], timeout: 10.0)
    }
    
    

    func testAddMenuItem() {
        let name = "Waffles Item"
        let specification = "Great waffles to enjoy!"
        let imageUrl = "https://www.graceandgoodeats.com/wp-content/uploads/2018/09/homemade-waffles.jpg"
        
        let newMenuItem = modelController!.add(MenuItem.self)
        XCTAssertNotNil(newMenuItem)
        
        newMenuItem?.name = name
        newMenuItem?.specification = specification
        newMenuItem?.imageUrl = imageUrl
        XCTAssertEqual(name, newMenuItem?.name, "Waffles Item")
        XCTAssertEqual(specification, newMenuItem?.specification, "Great waffles to enjoy!")
        XCTAssertEqual(imageUrl, newMenuItem?.imageUrl, "https://www.graceandgoodeats.com/wp-content/uploads/2018/09/homemade-waffles.jpg")
    }
    
    
    func testTotalMenuItem() {
        
        let newMenuItem = modelController!.add(MenuItem.self)
        
        newMenuItem?.name = "Waffles Item"
        newMenuItem?.specification = "Great waffles to enjoy!"
        newMenuItem?.imageUrl = "https://www.graceandgoodeats.com/wp-content/uploads/2018/09/homemade-waffles.jpg"
        
        let total = modelController!.total(MenuItem.self)
        XCTAssertGreaterThan(total, 0)
    }
    
    func testFetchMenuItem() {
        
        let name = "Waffles Item"
        let newMenuItem = modelController!.add(MenuItem.self)
        newMenuItem?.name = "Waffles Item"
        newMenuItem?.specification = "Great waffles to enjoy!"
        newMenuItem?.imageUrl = "https://www.graceandgoodeats.com/wp-content/uploads/2018/09/homemade-waffles.jpg"
        
        let predicate = NSPredicate(format: "name LIKE %@", name)
        let fetched = modelController!.fetch(MenuItem.self, predicate: predicate)
        
        guard let fetchedMenuItem = fetched?.last else {
            XCTAssertNotNil(fetched)
            return
        }
        
        XCTAssertEqual(fetchedMenuItem, newMenuItem, "The fetched MenuItem does not equal the created MenuItem!")
    }
    
    func testDeleteMenuItem() {
        
        //Test for deletion by objectID...
        let expectation1 = XCTestExpectation(description: "Delete core data object by objectID")
        
        let newMenuItem = modelController!.add(MenuItem.self)
        var total = modelController!.total(MenuItem.self)
        
        modelController!.delete(by: newMenuItem!.objectID) {
            
            let deletedTotal = self.modelController!.total(MenuItem.self)
            XCTAssertLessThan(deletedTotal, total)
            expectation1.fulfill()
        }
        
        //Test for deletion by predicate...
        let expectation2 = XCTestExpectation(description: "Delete core data object by predicate")
        
        let outdatedMenuItem = modelController!.add(MenuItem.self)
        let name = "Waffles Item"
        outdatedMenuItem?.name = name
        
        total = modelController!.total(MenuItem.self)
        let predicate = NSPredicate(format: "name LIKE %@", name)
        
        modelController!.delete(MenuItem.self, predicate: predicate) {
            
            let deletedTotal = self.modelController!.total(MenuItem.self)
            XCTAssertLessThan(deletedTotal, total)
            expectation2.fulfill()
        }
        
        wait(for: [expectation1, expectation2], timeout: 10.0)
    }

}
