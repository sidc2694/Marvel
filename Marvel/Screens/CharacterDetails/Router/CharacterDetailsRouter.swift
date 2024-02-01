//
//  CharacterDetailsRouter.swift
//  Marvel
//
//  Created by Siddharth Chauhan on 20/11/23.
//

import Foundation
import UIKit

class CharacterDetailsRouter {
    class func createCharacterDetailsViewController(characterDetails: CharacterModel) -> UIViewController? {
        let viewController = UIStoryboard(name: Constants.Storyboard.main, bundle: .main).instantiateViewController(identifier: Constants.Screens.characterDetailsViewController) { coder in
            CharacterDetailsViewController(viewModel: CharacterDetailsViewModel(characterDetails: characterDetails), coder: coder)
        }
        return viewController
    }
}
