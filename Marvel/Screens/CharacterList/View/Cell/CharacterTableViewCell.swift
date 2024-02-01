//
//  CharacterTableViewCell.swift
//  Marvel
//
//  Created by Siddharth Chauhan on 19/11/23.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblCharacterName: UILabel!
    @IBOutlet weak var lblCharacterDescription: UILabel!
    
    // MARK: - Overridden Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: - Cell Methods
    func setData(thumbnailUrl: URL?, characterName: String?, characterDescr: String?) {
        imgView.downloadImage(url: thumbnailUrl)
        lblCharacterName.text = characterName
        lblCharacterDescription.text = characterDescr
    }
}
