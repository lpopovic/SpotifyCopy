//
//  CategoryCollectionViewCell.swift
//  Spotify
//
//  Created by Lazar Popovic on 3/24/21.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    static let identifier = "CategoryCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.image = UIImage(systemName: "music.quarternote.3",withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))
        
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        
        return label
    }()
    
    private let colors: [UIColor] = [
        .systemPurple,
        .systemRed,
        .systemTeal,
        .systemBlue,
        .systemGreen,
        .systemOrange,
        .systemIndigo,
        .systemPink,
        .darkGray,
        .lightGray,
        .purple,
        .brown
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        addSubview(imageView)
        addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        imageView.image = UIImage(systemName: "music.quarternote.3",withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(x: 10, y: contentView.height / 2, width: contentView.width - 20, height: contentView.height / 2)
        imageView.frame = CGRect(x: contentView.width / 2, y: 10, width: contentView.width / 2, height: contentView.height / 2)
    }
    
    func configure(with viewModal: CategoryCollectionViewCellViewModel) {
        label.text = viewModal.title
        imageView.sd_setImage(with: viewModal.artworkURL, completed: nil)
        contentView.backgroundColor = colors.randomElement()
    }
}
