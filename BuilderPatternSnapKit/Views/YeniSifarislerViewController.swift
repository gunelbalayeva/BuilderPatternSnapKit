//
//  YeniSifarislerViewController.swift
//  BuilderPatternSnapKit
//
//  Created by User on 28.05.25.
//

import UIKit
import SnapKit

class YeniSifarislerViewController:UIViewController {
    
    private var orders: [SifarisEtInputData] = []
    private let viewModel: SifarisEtViewModel
    private var tableViewHeightConstraint: Constraint?
    
    private let tableview :UITableView = {
        let tableview = UITableView()
        return tableview
    }()
    private let toplamContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .ligthBlue
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let toplamLabel: UILabel = {
        let label = UILabel()
        label.text = "Toplam məbləğ (TL): 00.00"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .darkGray
        return label
    }()
    
    private let elaveEtButton: BaseButton = {
        let button = BaseButton()
        button.setTitle("Sifariş et", for: .normal)
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        setupNavigationBar()
        setupUI()
        tableview.delegate = self
        tableview.dataSource = self
        viewModel.subscribe(self)
        tableview.register(SifarisCell.self, forCellReuseIdentifier: SifarisCell.identifier)
        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = 60
        elaveEtButton.addTarget(self, action: #selector(didTapElaveEt), for: .touchUpInside)
        
    }
    
    init(orders: [SifarisEtInputData], viewModel: SifarisEtViewModel, tableViewHeightConstraint: Constraint? = nil) {
        self.orders = orders
        self.viewModel = viewModel
        self.tableViewHeightConstraint = tableViewHeightConstraint
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableViewHeightConstraint?.update(offset: tableview.contentSize.height)
    }
    
    public func setupUI() {
        view.addSubview(tableview)
        view.addSubview(toplamContainerView)
        view.addSubview(elaveEtButton)
        toplamContainerView.addSubview(toplamLabel)
        
        tableview.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            tableViewHeightConstraint = make.height.equalTo(1).constraint
        }
        
        toplamContainerView.snp.makeConstraints { make in
            make.top.equalTo(tableview.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        toplamLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(12)
        }
        
        elaveEtButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.height.equalTo(48)
        }
    }
    
    
    private func setupNavigationBar() {
        title = "Yeni sifariş"
        view.backgroundColor = .systemBackground
        navigationItem.hidesBackButton = true
        let addButton = UIBarButtonItem(
            image: UIImage(named: "add"),
            style: .plain,
            target: self,
            action: #selector(addOrderTapped)
        )
        addButton.tintColor = .bg
        navigationItem.rightBarButtonItem = addButton
        
    }
    
    @objc
    private func addOrderTapped() {
        guard let firstOrder = orders.first else { return }
        let vc = SifarisBeyannameViewController(order: firstOrder)
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    private func didTapElaveEt (){
        viewModel.fetchData()
    }
}
extension YeniSifarislerViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tv: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tv: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tv.dequeueReusableCell(withIdentifier: SifarisCell.identifier, for: indexPath) as! SifarisCell
        let order = orders[indexPath.row]
        cell.linkLabel.text    = order.getMehsulLinki
        cell.commentLabel.text = order.getSherh
        cell.priceLabel.text   = "Toplam: \(order.getToplamMebleg) TL"
        return cell
    }
    
    func tableView(_ tv: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedOrder = orders[indexPath.row]
        
        let vc = SifarisBeyannameViewController(order: selectedOrder)
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension YeniSifarislerViewController :SifarisEtDelegate {
    func render(_ state: SifarisEtState) {
        switch state {
        case .loading(let link, let mebleg, let kargo, let sherh, let toplam):
            let newVM = SifarisEtInputData(
                mehsulLinki: link,
                mebleg: mebleg,
                kargo: kargo,
                sherh: sherh,
                toplamMebleg: toplam
            )
            orders.append(newVM)
            tableview.reloadData()
            let sum = orders
                .compactMap { Double($0.getToplamMebleg) }
                .reduce(0, +)
            toplamLabel.text = String(format: "Toplam məbləğ (TL): %.2f", sum)
            
        case .success:
            break
        case .failure(let error):
            let alert = UIAlertController(
                title: "Xəta",
                message: error,
                preferredStyle: .alert
            )
            alert.addAction(.init(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
}
