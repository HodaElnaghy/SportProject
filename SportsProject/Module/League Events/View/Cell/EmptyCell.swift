//
//  EmptyCell.swift
//  SportsProject
//
//  Created by Hend on 06/10/2023.
//

import UIKit

class EmptyCell: UICollectionViewCell {
    @IBOutlet weak var emptyCellLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        emptyCellLabel.textAlignment = .center
        emptyCellLabel.textColor = .gray
        emptyCellLabel.font = UIFont.systemFont(ofSize: 16)
       
        // Initialization code
    }

}
