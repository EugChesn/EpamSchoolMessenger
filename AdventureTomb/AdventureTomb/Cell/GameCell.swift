//
//  GameCell.swift
//  AdventureTomb
//
//  Created by Admin on 15.03.2020.
//  Copyright © 2020 MaximMasov. All rights reserved.
//

import UIKit

class GameCell: UICollectionViewCell {

    @IBOutlet weak var background: UIView!
    let nib = UINib(nibName: String(describing: GameCell.self), bundle: nil)
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func changeColor(){
        self.backgroundColor = UIColor.black
    }
    func playerMove(){
        if self.backgroundColor == UIColor.black{
            self.backgroundColor = UIColor.green
        }
    }
}
