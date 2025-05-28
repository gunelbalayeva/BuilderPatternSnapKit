//
//  SifarisCell.swift
//  BuilderPatternSnapKit
//
//  Created by User on 28.05.25.
//

import UIKit
import SnapKit
class SifarisCell: UITableViewCell {
    static let identifier = "SifarisCell"

    let containerView = UIView()
    let linkLabel = UILabel()
    let commentLabel = UILabel()
    let priceLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear 

        contentView.addSubview(containerView)
        containerView.backgroundColor = .textField
        containerView.layer.cornerRadius = 12
        containerView.layer.masksToBounds = true

        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 0)) 
        }

        containerView.addSubview(linkLabel)
        containerView.addSubview(commentLabel)
        containerView.addSubview(priceLabel)

        linkLabel.font = .systemFont(ofSize: 16)
        linkLabel.textColor = .bg
        commentLabel.font = .systemFont(ofSize: 14)
        priceLabel.textColor = .gray
        priceLabel.font = .systemFont(ofSize: 14, weight: .bold)

        linkLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview().inset(12)
        }
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(linkLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(12)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(commentLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}
