//
//  YeniSifarisViewController.swift
//  BuilderPatternSnapKit
//
//  Created by User on 27.05.25.
//

import UIKit

class YeniSifarisViewController :UIViewController {
  
    private let mehsulLinkiTextField = createTextField(placeholder: "Məhsul linki")
    private let meblegTextField = createTextField(placeholder: "Məbləğ (TL)", keyboardType: .decimalPad)
    private let kargoTextField = createTextField(placeholder: "Kargo məbləği (TL)", keyboardType: .decimalPad)
    private let sherhTextField = createTextField(placeholder: "Şərh")
    private let toplamContainerView: UIView = {
           let view = UIView()
           view.backgroundColor = .ligthBlue
           view.layer.cornerRadius = 10
           return view
       }()

    private let toplamTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Toplam məbləğ (TL)"
        tf.font = .systemFont(ofSize: 16, weight: .medium)
        tf.textColor = .darkGray
        tf.backgroundColor = .ligthBlue
        tf.keyboardType = .decimalPad
        tf.borderStyle = .roundedRect
        return tf
    }()


       private let elaveEtButton: BaseButton = {
           let button =  BaseButton()
           button.setTitle("Əlavə et", for: .normal)
           button.heightAnchor.constraint(equalToConstant: 45).isActive = true
           button.addTarget(self, action: #selector(elaveEtTapped), for: .touchUpInside)
           return button
       }()

       override func viewDidLoad() {
           super.viewDidLoad()
           view.backgroundColor = .systemBackground
           navigationItem.hidesBackButton = true
           setupNavigationBar()
           setupLayout()
       }

    private func setupLayout() {
            let stackView = UIStackView(arrangedSubviews: [
                mehsulLinkiTextField,
                meblegTextField,
                kargoTextField,
                sherhTextField
            ])
            stackView.axis = .vertical
            stackView.spacing = 15
            view.addSubview(stackView)
            stackView.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
                make.leading.equalToSuperview().offset(20)
                make.trailing.equalToSuperview().inset(20)
            }

           view.addSubview(toplamContainerView)
            toplamContainerView.snp.makeConstraints { make in
                make.top.equalTo(stackView.snp.bottom).offset(20)
                make.leading.equalToSuperview().offset(20)
                make.trailing.equalToSuperview().inset(20)
                make.height.equalTo(50)
            }

            toplamContainerView.addSubview(toplamTextField)
            toplamTextField.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(12)
                make.centerY.equalToSuperview()
                make.trailing.lessThanOrEqualToSuperview().inset(12)
            }

            view.addSubview(elaveEtButton)
            elaveEtButton.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(16)
                make.trailing.equalToSuperview().inset(16)
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
                make.height.equalTo(48)
            }
        }
    
    @objc
    private func elaveEtTapped() {
        let inputdata = SifarisEtInputData(
            mehsulLinki: mehsulLinkiTextField.text ?? "",
            mebleg: meblegTextField.text ?? "",
            kargo: kargoTextField.text ?? "",
            sherh: sherhTextField.text ?? "",
            toplamMebleg: toplamTextField.text?.components(separatedBy: ": ").last ?? "0"
        )

        let vc = SifarisEtBuilder(inputdata: inputdata).build()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    
    @objc
    private func deleteOrderTapped() {
        navigationController?.popViewController(animated: true)
    }

       private static func createTextField(placeholder: String,
                                           keyboardType: UIKeyboardType = .default) -> UITextField {
           let textField = UITextField()
           textField.placeholder = placeholder
           textField.keyboardType = keyboardType
           textField.borderStyle = .none
           textField.backgroundColor = .textField
           textField.layer.cornerRadius = 8

           let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
           textField.leftView = paddingView
           textField.leftViewMode = .always
           textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
           textField.setContentHuggingPriority(.defaultLow, for: .vertical)
           textField.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
           return textField
       }

       private func setupNavigationBar() {
           let titleLabel = UILabel()
           titleLabel.text = "Sifariş et"
           titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
           titleLabel.textColor = .black

           navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)

           let deleteButton = UIBarButtonItem(
               image: UIImage(named: "delete")?.withRenderingMode(.alwaysOriginal),
               style: .plain,
               target: self,
               action: #selector(deleteOrderTapped)
           )
           deleteButton.tintColor = .black
           navigationItem.rightBarButtonItem = deleteButton
       }
}
