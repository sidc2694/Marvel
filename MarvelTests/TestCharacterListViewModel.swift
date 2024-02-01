//
//  TestCharacterListViewModel.swift
//  MarvelTests
//
//  Created by Siddharth Chauhan on 24/11/23.
//

import Foundation
import XCTest
@testable import Marvel

final class TestCharacterListViewModel: XCTestCase {
    
    func testSuccessFetchCharacterList() {
        let objVM = CharacterListViewModel(apiRequestManager: MockAPIManager.shared)
        objVM.eventState = { event in
            switch event {
            case .dataLoaded:
                XCTAssert(true)
            case .noDataFound:
                XCTAssert(true)
            case .stopLoading:
                break
            case .errorLoading(let error):
                XCTFail("Error: \(error)")
            }
        }
        objVM.fetchCharacterList()
    }
    
    func testFailureFetchCharacterList() {
        let objVM = CharacterListViewModel(apiRequestManager: MockAPIManager.shared)
        objVM.eventState = { event in
            switch event {
            case .dataLoaded:
                XCTFail()
            case .noDataFound:
                XCTFail()
            case .stopLoading:
                break
            case .errorLoading(let error):
                XCTAssertNotNil(error)
            }
        }
        objVM.fetchCharacterList()
    }
    
}
