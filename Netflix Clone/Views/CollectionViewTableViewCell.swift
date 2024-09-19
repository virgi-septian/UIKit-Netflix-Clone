//
//  CollectionViewTableViewCell.swift
//  Netflix Clone
//
//  Created by Virgi Septian on 19/09/24.
//

import UIKit

class CollectionViewTableViewCell: UITableViewCell {
    static let idetifier = "CollectionViewTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemPink
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
}
