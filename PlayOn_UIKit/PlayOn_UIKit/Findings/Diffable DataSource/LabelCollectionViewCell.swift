//
//  LabelCollectionViewCell.swift
//  PlayOn_UIKit
//
//  Created by 김동욱 on 2022/12/28.
//

import UIKit

class LabelCollectionViewCell: UICollectionViewCell {
    static let identifier = "LabelCollectionViewCell"
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
        configureHierachy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    private func setUpUI() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    private func configureHierachy() {
        contentView.addSubview(label)
        
        let inset = CGFloat(10)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
