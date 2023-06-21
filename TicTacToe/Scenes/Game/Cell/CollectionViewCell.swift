//
//  CollectionViewCell.swift
//  TicTacToe
//
//  Created by Marina Aguiar on 6/19/23.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellImageView: UIImageView!

    func setup(indicator: String) {
        backgroundColor = UIColor(red: 0.92, green: 0.47, blue: 0.44, alpha: 1.00)
        layer.cornerRadius = 25
        cellImageView.image = UIImage(systemName: indicator)
        cellImageView.tintColor = .white
    }

    func fillWinnerCells(indicator: String) {
        backgroundColor = UIColor(red: 0.85, green: 0.93, blue: 0.57, alpha: 1.00)
        cellImageView.image = UIImage(systemName: indicator)
        cellImageView.tintColor = .white
    }
}
