//
//  nibCell.swift
//  Collection View Nested Group with Nib
//
//  Created by Artemy Ozerski on 19/06/2022.
//

import UIKit

class nibCell: UICollectionViewCell {
static let reuseIdentifier = "customCell"
    @IBOutlet weak var labelOutlet: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override var intrinsicContentSize: CGSize{
        return CGSize(width: 100, height: 100)
    }

}
