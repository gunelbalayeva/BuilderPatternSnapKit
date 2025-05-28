//
//  SifarisBeyannameViewController.swift
//  BuilderPatternSnapKit
//
//  Created by User on 28.05.25.
//

import UIKit

class SifarisBeyannameViewController :UIViewController {
    
    private let order: SifarisEtInputData
    private let headerView:UIView = {
        let vw = UIView()
        vw.backgroundColor = .ligthGreen
        vw.layer.borderWidth = 1
        vw.layer.borderColor = UIColor.green.cgColor
        vw.layer.cornerRadius = 12
        
        return vw
    }()
    
    private let centerLabel :UILabel = {
        let label = UILabel()
        label.text = "DGK-ya bəyan olunub"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        label.textColor = UIColor(named: "green")
        return label
    }()
    
    
    private let firstButton : UIButton =  {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.backgroundColor = .ligthBlue
        button.setTitle("Borcunu ödə", for: .normal)
        button.setTitleColor(.bg, for: .normal)
        return button
    } ()
    
    private let secondButton : BaseButton =  {
        let button = BaseButton()
        button.setTitle("Bağla", for: .normal)
        return button
    } ()
    
    private let stackview: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 4
        stack.distribution = .equalSpacing
        return stack
    }()
    
    func makeRow(title: String, value: String, titleFont: UIFont, valueFont: UIFont, valueColor: UIColor) -> UIStackView {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = titleFont
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = valueFont
        valueLabel.textColor = valueColor
        valueLabel.numberOfLines = 0
        valueLabel.textAlignment = .right
        
        let row = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        row.axis = .horizontal
        row.spacing = 8
        row.alignment = .center
        row.distribution = .fill
        return row
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.hidesBackButton = true
        setupNavigationBar()
        setupUI()
        setupButtonsLayout()
        firstButton.addTarget(self, action: #selector(handlePay), for: .touchUpInside)
        secondButton.addTarget(self, action: #selector(handleClose), for: .touchUpInside)
    }
    init(order: SifarisEtInputData) {
        self.order = order
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        view.addSubview(headerView)
        headerView.addSubview(centerLabel)
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.leading.equalToSuperview().inset(16)
            make.width.equalTo(175)
            make.height.equalTo(40)
        }
        centerLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        view.addSubview(stackview)
        stackview.axis = .vertical
        stackview.spacing = 8
        stackview.alignment = .fill
        stackview.distribution = .fill
        stackview.layer.cornerRadius = 12
        stackview.layer.masksToBounds = true
        stackview.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(110)
        }
        
        let linkRow = makeRow(
            title: "Link:",
            value: order.mehsulLinki,
            titleFont: .systemFont(ofSize: 16),
            valueFont: .systemFont(ofSize: 14),
            valueColor: .bg
        )
        
        let commentRow = makeRow(
            title: "Şərh:",
            value: order.sherh,
            titleFont: .systemFont(ofSize: 16),
            valueFont: .systemFont(ofSize: 14),
            valueColor: .black
        )
        
        let priceRow = makeRow(
            title: "Toplam məbləğ:",
            value: "\(order.getToplamMebleg) TL",
            titleFont: .systemFont(ofSize: 16),
            valueFont: .systemFont(ofSize: 14),
            valueColor: .darkGray
        )
        
        [linkRow, commentRow, priceRow].forEach { stackview.addArrangedSubview($0) }
    }
    
    private func setupNavigationBar() {
        let imageView = UIImageView()
        imageView.image = .tr
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(24)
        }
        let titleLabel = UILabel()
        titleLabel.text = "SKY501188226"
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = .black
        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: stackView)
        let deleteButton = UIBarButtonItem(
            image: UIImage(named: "delete")?.withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(deleteOrderTapped)
        )
        deleteButton.tintColor = .black
        navigationItem.rightBarButtonItem = deleteButton
    }
    
    private func setupButtonsLayout() {
        let buttonStackView = UIStackView(arrangedSubviews: [firstButton, secondButton])
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 12
        buttonStackView.distribution = .fillEqually
        view.addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
            make.height.equalTo(48)
        }
    }

    
    @objc
    private func deleteOrderTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc private func handlePay() {
        print("Borc ödənir...")
    }
    
    @objc
    private func handleClose() {
        navigationController?.popViewController(animated: true)
    }
    
}
