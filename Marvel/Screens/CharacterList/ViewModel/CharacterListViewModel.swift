//
//  CharacterListViewModel.swift
//  Marvel
//
//  Created by Siddharth Chauhan on 19/11/23.
//

import Foundation
import Reachability

// This enum lists all the events that view controller will receive when view model triggers it.
enum CharacterListEvents {
    case dataLoaded
    case noDataFound
    case stopLoading
    case errorLoading(String)
}

class CharacterListViewModel {
    
    //MARK: - Private Variables
    private var characterList: [CharacterModel] = []
    private var totalCharacters: Int = 0
    private var requestModel: CharacterListRequest!
    private var apiRequestManager: APIRequestProtocol
    
    // MARK: - Internal Variables
    
    // This closure is used to send events to the receiver.
    var eventState: ((CharacterListEvents) -> Void)?
    
    //MARK: - Initializer
    
    // Injecting dependency of APIRequestProtocol protocol to make it testable using mock data.
    init(apiRequestManager: APIRequestProtocol = APIManager.shared) {
        self.apiRequestManager = apiRequestManager
    }
}

//MARK: - CharacterListViewModelProtocol Methods
extension CharacterListViewModel: CharacterListViewModelProtocol {
    
    // Fetches data from webservice and triggers events by calling closure.
    func fetchCharacterList() {
        // Create request model with limit to fetch 20 objects at a time from the offset value.
        requestModel = CharacterListRequest(limit: 20, offset: characterList.count)
        
        // Call request on request manager with expected return type object as a "type" parameter and "module" parameter contains type of request with request model.
        apiRequestManager.request(type: [CharacterModel].self, module: .characterList(requestModel)) {  [weak self] result in
            guard let self else { return }
            self.eventState?(CharacterListEvents.stopLoading)
            switch result {
            case .success(let dataModel):
                self.totalCharacters = dataModel.total ?? 0
                self.characterList.isEmpty ? (self.characterList = dataModel.results ?? []) : self.characterList.append(contentsOf: dataModel.results ?? [])
                if self.characterList.count > 0 {
                    self.eventState?(CharacterListEvents.dataLoaded)
                } else {
                    self.eventState?(CharacterListEvents.noDataFound)
                }
            case .failure(let error):
                self.eventState?(CharacterListEvents.errorLoading(error.failureReason ?? Constants.Errors.somethingWentWrong))
            }
        }
    }
    
    func getCharactersCount() -> Int { characterList.count }
    
    func getTotalCharactersCount() -> Int { totalCharacters }
    
    func getCharacterAtIndex(index: Int) -> CharacterModel? { characterList[index] }
}
