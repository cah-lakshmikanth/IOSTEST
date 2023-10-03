//
//  ImageTableViewCell.swift
//  iOSPoc
//
//  Created by Lakshmikanth on 02/10/23.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    
    @IBOutlet weak var cellImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func update(imageUrl: String) {
        cellImage.setImage(url: imageUrl, placeholderImage: UIImage(named: "placeholder"))
    }

}
