//
//  CharacterListViewModelProtocol.swift
//  Marvel
//
//  Created by Siddharth Chauhan on 30/01/24.
//

import Foundation

// CharacterListViewModelProtocol contains only those methods and variables of CharacterListViewModel which needs to be exposed to the CharacterListViewController.
protocol CharacterListViewModelProtocol {
    func fetchCharacterList()
    func getCharactersCount() -> Int
    func getTotalCharactersCount() -> Int
    func getCharacterAtIndex(index: Int) -> CharacterModel?
    
    var eventState: ((CharacterListEvents) -> Void)? { get set }
}
