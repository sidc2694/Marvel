//
//  Constants.swift
//  Marvel
//
//  Created by Siddharth Chauhan on 18/11/23.
//

import Foundation

enum Constants {
    static let applicationName: String = "Marvel"
    
    enum Keys {
        static let publicApiKey: String = "67204880e65ea9f52c616956859a77bb"
        static let privateApiKey: String = "713d35fd9b90f8b3fff774ff633409302356265b"
    }
    
    enum Storyboard {
        static let main: String = "Main"
    }
    
    enum Screens {
        static let characterListViewController: String = "CharacterListViewController"
        static let characterDetailsViewController: String = "CharacterDetailsViewController"
    }
    
    enum ScreenTitles {
        static let characterDetails: String = "Characters Details"
    }
    
    enum UserDefaultKeys {
        static let bookmarkedCharacters: String = "BookmarkedCharacters"
    }
    
    enum Images {
        static let bookmark: String = "bookmark"
        static let bookmarkFill: String = "bookmark.fill"
        static let placeholderImage = "photo.artframe"
    }
    
    enum Errors {
        static let invalidUrl: String = "Webservice url is invalid"
        static let invalidBody: String = "Request body is invalid"
        static let invalidData: String = "Webservice response data is invalid"
        static let invalidResponse: String = "Webservice response is invalid"
        static let decodingFailed: String = "Decoding of response failed"
        static let noCharactersFound: String = "No characters found"
        static let noComicsFound: String = "No comics found"
        static let somethingWentWrong: String = "Something went wrong"
        static let noInternetAvailable: String = "Internet connection is not available. Please connect to internet."
    }
    
    static let comics: String = "Comics"
}
