//
//  CharacterDetailsViewModel.swift
//  Marvel
//
//  Created by Siddharth Chauhan on 20/11/23.
//

import Foundation

// This enum lists all the events that view controller will receive when view model triggers it.
enum CharacterDetailsEvents {
    case dataLoaded
    case noDataFound
    case stopLoading
    case errorLoading(String)
}

class CharacterDetailsViewModel {
    
    // MARK: - Private Variables
    private var characterDetails: CharacterModel!
    private var comicsList: [ComicsDetails]!
    private var apiRequestManager: APIRequestProtocol
    
    // MARK: - Internal Variables
    
    // This closure is used to send events to the receiver.
    var eventState: ((CharacterDetailsEvents) -> Void)?
    
    // MARK: - Initializers
    
    // Injecting dependency of APIRequestProtocol protocol to make it testable using mock data.
    init(apiRequestManager: APIRequestProtocol = APIManager.shared, characterDetails: CharacterModel) {
        self.apiRequestManager = apiRequestManager
        self.characterDetails = characterDetails
    }
    
}

// MARK: - CharacterDetailsViewModelProtocol Methods
extension CharacterDetailsViewModel: CharacterDetailsViewModelProtocol {
    
    // Fetches data from webservice and triggers events by calling closure.
    func fetchComicsDetails() {
        // Create request model with limit to fetch 5 objects of given character id.
        let requestModel = ComicsRequestModel(characterId: characterDetails.id, limit: 5)
        
        // Call request on request manager with expected return type object as a "type" parameter and "module" parameter contains type of request with request model.
        apiRequestManager.request(type: [ComicsDetails].self, module: .comicsList(requestModel)) { [weak self] result in
            guard let self else { return }
            self.eventState?(CharacterDetailsEvents.stopLoading)
            switch result {
            case .success(let dataModel):
                
                self.comicsList = dataModel.results
                if !self.comicsList.isEmpty {
                    self.eventState?(CharacterDetailsEvents.dataLoaded)
                } else {
                    self.eventState?(CharacterDetailsEvents.noDataFound)
                }
            case .failure(let error):
                self.eventState?(CharacterDetailsEvents.errorLoading(error.failureReason ?? Constants.Errors.somethingWentWrong))
            }
        }
    }
    
    func totalComicsList() -> Int? { comicsList?.count }
    
    func getComicAtIndex(index: Int) -> ComicsDetails? { comicsList?[index] }
    
    func getCharacterName() -> String {
        characterDetails.name ?? Constants.ScreenTitles.characterDetails
    }
    
    func getImageThumbnailUrl() -> URL? {
        characterDetails.thumbnail?.thumbnailUrl
    }
}

