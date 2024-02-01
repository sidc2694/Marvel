//
//  ComicsListTableViewCell.swift
//  Marvel
//
//  Created by Siddharth Chauhan on 22/11/23.
//

import UIKit

class ComicsListTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    // MARK: - Overridden Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Cell Methods
    func setData(thumbnailUrl: URL?, comicTitle: String?) {
        imgView.downloadImage(url: thumbnailUrl)
        lblTitle.text = comicTitle
    }

}
