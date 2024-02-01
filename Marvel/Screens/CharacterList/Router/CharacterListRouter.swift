//
//  CharacterListRouter.swift
//  Marvel
//
//  Created by Siddharth Chauhan on 20/11/23.
//

import Foundation
import UIKit

class CharacterListRouter {
    
    class func createCharacterListViewController() -> UIViewController {
        let viewController = UIStoryboard(name: Constants.Storyboard.main, bundle: .main).instantiateViewController(identifier: Constants.Screens.characterListViewController) { coder in
            CharacterListViewController(viewModel: CharacterListViewModel(), coder: coder)
        }
        return viewController
    }
    
    class func navigateToCharacterDetailsScreen(viewController: UIViewController, characterDetails: CharacterModel) {
        let characterDetailsVC = CharacterDetailsRouter.createCharacterDetailsViewController(characterDetails: characterDetails)
        if let vc = characterDetailsVC {
            viewController.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
