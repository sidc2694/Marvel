//
//  TestCharacterDetailsViewModel.swift
//  MarvelTests
//
//  Created by Siddharth Chauhan on 24/11/23.
//

import Foundation
import XCTest
@testable import Marvel

final class TestCharacterDetailsViewModel: XCTestCase {
    
    func testSuccessFetchComicsDetails() {
        let data = MockNetworkHandler().readLocalJSONFile(forName: "CharacterDetails.json")
        let characterModel = try? JSONDecoder().decode(CharacterModel.self, from: data!)
        let objVM = CharacterDetailsViewModel(apiRequestManager: MockAPIManager.shared, characterDetails: characterModel!)
        
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
        
        objVM.fetchComicsDetails()
    }
    
    func testFailureFetchComicsDetails() {
        let data = MockNetworkHandler().readLocalJSONFile(forName: "CharacterDetails.json")
        let characterModel = try? JSONDecoder().decode(CharacterModel.self, from: data!)
        let objVM = CharacterDetailsViewModel(apiRequestManager: MockAPIManager.shared, characterDetails: characterModel!)
        
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
        
        objVM.fetchComicsDetails()
    }
}
