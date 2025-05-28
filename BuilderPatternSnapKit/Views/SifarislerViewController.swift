//
//  SifarislerViewController.swift
//  BuilderPatternSnapKit
//
//  Created by User on 27.05.25.
//

import UIKit
import SnapKit

class SifarislerViewController: UIViewController {
    
    private let stackview: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sifariş əlavə et"
        label.font = .boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Lectus senectus pellentesque non tincidunt quisque donec nisl."
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .gray
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupUI()
        bindViewModel()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Sifarişlərim"
        let addButton = UIBarButtonItem(
            image: UIImage(named: "add"),
            style: .plain,
            target: self,
            action: #selector(addOrderTapped)
        )
        addButton.tintColor = .bg
        navigationItem.rightBarButtonItem = addButton
        
    }
    
    
    private func setupUI() {
        view.addSubview(stackview)
        stackview.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.greaterThanOrEqualToSuperview().offset(16)
            make.trailing.lessThanOrEqualToSuperview().offset(-16)
        }
        stackview.addArrangedSubview(titleLabel)
        stackview.addArrangedSubview(subtitleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.width.lessThanOrEqualToSuperview().offset(-32)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.width.lessThanOrEqualToSuperview().offset(-32)
        }
        
    }
    
    private func bindViewModel() {
        //            emptyStateLabel.isHidden = !viewModel.isOrderListEmpty
        //            emptyStateSubtitle.isHidden = !viewModel.isOrderListEmpty
        //            addOrderButton.isHidden = !viewModel.isOrderListEmpty
    }
    
    @objc
    private func addOrderTapped() {

        let vc = YeniSifarisViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

