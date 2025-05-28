//
//  BaseButton.swift
//  BuilderPatternSnapKit
//
//  Created by User on 28.05.25.
//

import UIKit

class BaseButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   private func setupUI() {
       backgroundColor = .bg
       titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
       setTitleColor(.white, for: .normal)
       layer.cornerRadius = 12
    }
}

