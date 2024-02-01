//
//  CharacterDetailsViewController.swift
//  Marvel
//
//  Created by Siddharth Chauhan on 20/11/23.
//

import UIKit
import SVProgressHUD

class CharacterDetailsViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var bottomView: UIView!
    
    // MARK: Private Variables
    private var objVM: CharacterDetailsViewModelProtocol!
    
    // MARK: Initializers
    
    /// Custom initializer to inject view model dependecy
    /// - Parameters:
    ///   - viewModel: Injecting dependency of CharacterDetailsViewModelProtocol type so that if anytime we want to change the view model related to this view controller, we don't need to make any changes in this file. It makes this view controller testable.
    ///   - coder: Storyboard is used to create this view controller so NSCoder is needed in order to call init(coder:) method.
    init?(viewModel: CharacterDetailsViewModelProtocol, coder: NSCoder) {
        self.objVM = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: ViewController Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = objVM.getCharacterName()
        self.setupUI()
        self.fetchComicsDetails()
    }
}

// MARK: Setup UI
private extension CharacterDetailsViewController {
    func setupUI() {
        self.tblView.isHidden = true
        self.imgView.kf.setImage(with: objVM.getImageThumbnailUrl())
        self.lblError.isHidden = true
    }
}

// MARK: API Call
private extension CharacterDetailsViewController {
    func fetchComicsDetails() {
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show()
        
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
                    self.lblError.text = Constants.Errors.noComicsFound
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
        
        objVM.fetchComicsDetails()
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension CharacterDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { objVM.totalComicsList() ?? 0 }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 100 }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let lblSectionTitle: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        lblSectionTitle.backgroundColor = .white
        lblSectionTitle.text = Constants.comics
        lblSectionTitle.font = .boldSystemFont(ofSize: 20)
        return lblSectionTitle
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ComicsListTableViewCell.self), for: indexPath) as! ComicsListTableViewCell
        if let comicDetails = objVM.getComicAtIndex(index: indexPath.row) {
            cell.setData(thumbnailUrl: comicDetails.thumbnail?.thumbnailUrl, comicTitle: comicDetails.title)
        }
        cell.selectionStyle = .none
        return cell
    }
}
