//
//  AppearanceCollectionViewCell.swift
//  Messenger
//
//  Created by Анастасия Демидова on 26.04.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import UIKit

class AppearanceCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var pictureImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.pictureImageView.image = nil
    }
    
    func setupCell(picture: UIImage) {
        self.pictureImageView.image = picture
    }
}
