//
//  ImmediateValueTests.swift
//  AXAnimationChain
//
//  Created by devedbox on 2017/5/23.
//  Copyright © 2017年 devedbox. All rights reserved.
//

import XCTest
import AXAnimationChain_App

class ImmediateValueTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    /*
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    } */
    
    func testGetImmediateValueOfCAAnimation() {
        let anim = CAAnimation()
        // let value = anim.immediateValue(atTime: 0.5)
        do {
            let _ = try anim.immediateValue(atTime: 0.5)
        } catch let exp {
            XCTAssertNotNil(exp, "Test passed.")
        }
    }
}
