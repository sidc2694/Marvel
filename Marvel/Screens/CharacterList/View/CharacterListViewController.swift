//
//  CharacterListViewController.swift
//  Marvel
//
//  Created by Siddharth Chauhan on 19/11/23.
//

import UIKit
import SVProgressHUD

class CharacterListViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblError: UILabel!
    
    // MARK: Private Variables
    private var objVM: CharacterListViewModelProtocol!
    
    // MARK: Initializers
    
    /// Custom initializer to inject view model dependecy
    /// - Parameters:
    ///   - viewModel: Injecting dependency of CharacterListViewModelProtocol type so that if anytime we want to change the view model related to this view controller, we don't need to make any changes in this file. It makes this view controller testable.
    ///   - coder: Storyboard is used to create this view controller so NSCoder is needed in order to call init(coder:) method.
    init?(viewModel: CharacterListViewModelProtocol, coder: NSCoder) {
        self.objVM = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: ViewController Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = Constants.applicationName
        setupUI()
        
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show()
        fetchCharacterList()
    }
}

// MARK: Setup UI
private extension CharacterListViewController {
    func setupUI() {
        tblView.isHidden = true
        tblView.keyboardDismissMode = .interactive
        lblError.isHidden = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

// MARK: API Call
private extension CharacterListViewController {
    @objc func fetchCharacterList() {
        
        // Receives events triggered from view model
        objVM.eventState = { event in
            switch event {
            case .dataLoaded:
                DispatchQueue.main.async {
                    self.tblView.isHidden = false
                    self.lblError.isHidden = true
                    self.tblView.reloadData()
                }
            case .noDataFound:
                DispatchQueue.main.async {
                    self.tblView.isHidden = true
                    self.lblError.isHidden = false
                    self.lblError.text = Constants.Errors.noCharactersFound
                }
            case .stopLoading:
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                }
            case .errorLoading(let error):
                DispatchQueue.main.async {
                    self.lblError.isHidden = false
                    self.lblError.text = error
                }
            }
        }
        
        objVM.fetchCharacterList()
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension CharacterListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { objVM.getCharactersCount() }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UIDevice.current.userInterfaceIdiom == .phone ? 100 : 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CharacterTableViewCell.self), for: indexPath) as! CharacterTableViewCell
        if let characterDetails = objVM.getCharacterAtIndex(index: indexPath.row) {
            cell.setData(thumbnailUrl: characterDetails.thumbnail?.thumbnailUrl, characterName: characterDetails.name, characterDescr: characterDetails.description)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let characterDetails = objVM.getCharacterAtIndex(index: indexPath.row) {
            CharacterListRouter.navigateToCharacterDetailsScreen(viewController: self, characterDetails: characterDetails)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Load next 20 items when user scrolls to bottom of table view and all the characters are not yet loaded.
        if indexPath.row == objVM.getCharactersCount() - 1, objVM.getCharactersCount() < objVM.getTotalCharactersCount() {
            fetchCharacterList()
        }
    }
}
