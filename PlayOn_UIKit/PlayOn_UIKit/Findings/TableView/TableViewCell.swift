//
//  TableViewCell.swift
//  PlayOn_UIKit
//
//  Created by 김동욱 on 2022/12/30.
//

import UIKit

class TableViewCell: UITableViewCell {
    static let identifier = "TableViewCell"
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
