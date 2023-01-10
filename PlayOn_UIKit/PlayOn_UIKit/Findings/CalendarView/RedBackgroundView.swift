//
//  RedBackgroundView.swift
//  PlayOn_UIKit
//
//  Created by 김동욱 on 2023/01/10.
//

import UIKit

class RedBackgroundView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
