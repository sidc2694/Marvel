//
//  CharacterDetailsViewModelProtocol.swift
//  Marvel
//
//  Created by Siddharth Chauhan on 30/01/24.
//

import Foundation

// CharacterDetailsViewModelProtocol contains only those methods and variables of CharacterDetailsViewModel which needs to be exposed to the CharacterDetailsViewController.
protocol CharacterDetailsViewModelProtocol {
    func fetchComicsDetails()
    func totalComicsList() -> Int?
    func getComicAtIndex(index: Int) -> ComicsDetails?
    func getCharacterName() -> String
    func getImageThumbnailUrl() -> URL?
    
    var eventState: ((CharacterDetailsEvents) -> Void)? { get set }
}
