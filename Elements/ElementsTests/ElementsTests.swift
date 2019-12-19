//
//  ElementsTests.swift
//  ElementsTests
//
//  Created by Bienbenido Angeles on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import XCTest
@testable import Elements

class ElementsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func endPoints(endPoint: String, expectedDataCount: Int){
        //arrange
        let endPointString = endPoint
        guard let url = URL(string: endPointString) else {
            return
        }
        let exp = XCTestExpectation(description: "ENDPOINT VALID")
        let request = URLRequest(url: url)
        
        //act
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result{
            case .failure(let appError):
                XCTFail("App Err: \(appError)")
            case .success(let data):
                exp.fulfill()
                //assert
                XCTAssertGreaterThan(data.count, expectedDataCount)
            }
        }
        wait(for: [exp], timeout: 10)
    }

    func testGetEndPoint() {
        endPoints(endPoint: "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements", expectedDataCount: 70000)
    }
    
    func testPostEndPoint(){
        endPoints(endPoint: "http://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites", expectedDataCount: 7000)
    }
    
    func testRemainingElements(){
        //arrange
        endPoints(endPoint: "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements_remaining", expectedDataCount: 13000)
    }
    
    func testGetAtomicElements(){
        //arrange
        let exp = XCTestExpectation(description: "searches found")
        var elementsArr = [AtomicElement]()
        let expectedElements = 100
        var givenElements = Int()
        
        //act
        ElementAPIClient.getElements { (result) in
            switch result{
            case.failure(let appError):
                XCTFail("App Err: \(appError)")
            case .success(let elements):
                elementsArr = elements
                givenElements = elementsArr.count
                exp.fulfill()
            }
        }
        wait(for: [exp], timeout: 5.0)
        //assert
        XCTAssertEqual(expectedElements, givenElements, "Expected \(expectedElements) shows, instead of \(givenElements)")
    }
    
    func testPostAtomicElements(){
        //arrange
        let postingElement = AtomicElement(name: "Mendelevium", symbol: "Md", number: 101, atomicMass: 258, melt: nil, boil: nil, discoveredBy: "Lawrence Berkeley National Laboratory", favoritedBy: "testEx")

          let data = try! JSONEncoder().encode(postingElement)
          
          let exp = XCTestExpectation(description: "element posted successfully")
          
          let url = URL(string: "http://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites")!
          
          var request = URLRequest(url: url)
          request.httpMethod = "POST"
          request.httpBody = data
          
          // required to be valid JSON data being uploaded
          request.addValue("application/json", forHTTPHeaderField: "Content-Type")
          
          // act
          NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
              XCTFail("failed with error: \(appError)")
            case .success(let data):
              // assert
              let createdElement = try! JSONDecoder().decode(AtomicElement.self, from: data)
              XCTAssertEqual(postingElement.name, createdElement.name)
              exp.fulfill()
            }
          }
          
          wait(for: [exp], timeout: 5.0)
        }
}
