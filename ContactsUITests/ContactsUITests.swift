//
//  ContactsUITests.swift
//  ContactsUITests
//
//  Created by Zulwiyoza Putra on 8/31/17.
//  Copyright © 2017 Zulwiyoza Putra. All rights reserved.
//

import XCTest

class ContactsUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCreateContactWithoutImage() {
        
        
        let app = XCUIApplication()
        app.navigationBars["Contacts.ContactsTableView"].buttons["Add"].tap()
        
        let tablesQuery2 = app.tables
        let tablesQuery = tablesQuery2
        tablesQuery.textFields["First Name"].tap()
        tablesQuery2.children(matching: .cell).element(boundBy: 0).children(matching: .textField).element.typeText("John")
        tablesQuery.textFields["Last Name"].tap()
        tablesQuery2.children(matching: .cell).element(boundBy: 1).children(matching: .textField).element.typeText("Appleseed")
        app.tables.containing(.image, identifier:"user").element.swipeUp()
        tablesQuery.textFields["Mobile"].tap()
        tablesQuery2.children(matching: .cell).element(boundBy: 2).children(matching: .textField).element.typeText("62882379160")
        tablesQuery.textFields["Email"].tap()
        tablesQuery2.children(matching: .cell).element(boundBy: 3).children(matching: .textField).element.typeText("john@gmail.com")
        app.navigationBars["Contacts.ContactFormTableView"].buttons["Save"].tap()
        
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testCreateContactWithImage() {
        
        let app = XCUIApplication()
        app.navigationBars["Contacts.ContactsTableView"].buttons["Add"].tap()
        
        // TODO: - Add image here on imageView
        
        let tablesQuery2 = app.tables
        let tablesQuery = tablesQuery2
        tablesQuery.textFields["First Name"].tap()
        tablesQuery2.children(matching: .cell).element(boundBy: 0).children(matching: .textField).element.typeText("John")
        tablesQuery.textFields["Last Name"].tap()
        tablesQuery2.children(matching: .cell).element(boundBy: 1).children(matching: .textField).element.typeText("Appleseed")
        tablesQuery.textFields["Mobile"].tap()
        tablesQuery2.children(matching: .cell).element(boundBy: 2).children(matching: .textField).element.typeText("6282379160")
        tablesQuery.textFields["Email"].tap()
        tablesQuery2.children(matching: .cell).element(boundBy: 3).children(matching: .textField).element.typeText("john@apple.com")
        app.navigationBars["Contacts.ContactFormTableView"].buttons["Save"].tap()
        
        
        
    }
    
    func testViewContactDetail() {
        
        XCUIApplication().tables.staticTexts["Amanda  Puspa"].tap()
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testEditContact() {
        
    }
    
}
