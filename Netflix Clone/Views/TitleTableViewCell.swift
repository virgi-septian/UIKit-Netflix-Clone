//
//  TitleTableViewCell.swift
//  Netflix Clone
//
//  Created by Virgi Septian on 23/09/24.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
    static let identifier = "TitleTableViewCell"
    
    private let playTitleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titlePosterUIImageView: UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleAspectFill
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    override init (style: UITableViewCell.CellStyle, reuseIdentifier reusableIdentifier: String?){
        super.init(style: style, reuseIdentifier: reusableIdentifier)
        
        contentView.addSubview(titlePosterUIImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(playTitleButton)
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        let titlePosterUIImageViewConstraints = [
            titlePosterUIImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titlePosterUIImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            titlePosterUIImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
        ]
        
        NSLayoutConstraint.activate(titlePosterUIImageViewConstraints)
    }
    
    public func configure(with model: TitleViewModel){
        guard let url = URL(string: model.posterUrl) else { return }
        titlePosterUIImageView.sd_setImage(with: url, completed: nil)
        titleLabel.text = model.titleName
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
