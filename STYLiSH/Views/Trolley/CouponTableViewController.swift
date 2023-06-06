//
//  CouponTableViewController.swift
//  STYLiSH
//
//  Created by Lin Hsin-An on 2023/6/5.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import UIKit

class CouponTableViewController: STBaseViewController {
    
    var data: [Coupons.Coupon]? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    var selectedCouponIndexPath: IndexPath? {
        didSet {
            guard let data = data,
                  let selectedCouponIndexPath = selectedCouponIndexPath,
                  data.count > selectedCouponIndexPath.row else { return }
            selectedCoupon = data[selectedCouponIndexPath.row]
        }
    }
    var selectedCoupon: Coupons.Coupon?
    var passCoupon: ((IndexPath?, Coupons.Coupon?) -> ())?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CouponCell.self, forCellReuseIdentifier: CouponCell.reuseIdentifier)
        tableView.rowHeight = 180
        tableView.separatorStyle = .none
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        DivinationProvider.shared.getCoupon { [weak self] data in
            self?.data = data
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        passCoupon?(selectedCouponIndexPath, selectedCoupon)
    }
}

extension CouponTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10 // data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CouponCell.reuseIdentifier, for: indexPath)
        cell.selectionStyle = .none
        guard let couponCell = cell as? CouponCell else { return cell }
        if let tempdata = data,
           tempdata.count - 1 >= indexPath.row {
            guard let data = data?[indexPath.row] else { return cell }
            couponCell.configure(with: data.type,
                                 couponDiscountText: data.discount,
                                 couponExpirationDateText: data.expireTime)
            
        }
        couponCell.updateCells = { [weak self] in
            tableView.visibleCells.forEach { aCell in
                guard let aCell = aCell as? CouponCell else { return }
                if couponCell == aCell {
                    aCell.selectCheckbox()
                    self?.selectedCouponIndexPath = indexPath
                } else {
                    aCell.deselectCheckbox()
                }
            }
        }
        return couponCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let couponCell = cell as? CouponCell else { return }
        self.selectedCouponIndexPath == indexPath ? couponCell.selectCheckbox() : couponCell.deselectCheckbox()
    }
}
