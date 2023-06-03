//
//  DivinationResultViewController.swift
//  STYLiSH
//
//  Created by Lin Hsin-An on 2023/6/2.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import UIKit

class DivinationResultViewController: STBaseViewController {
    
    private let cellTypes: [DivinationCellType] = [.poem, .coupon, .prodcut]
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.titleView = UIImageView(image: .asset(.Image_Logo02))
        
        // Add the table view to the view controller's view
        view.addSubview(tableView)
        
        // Set up the table view constraints
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        // Configure the table view
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PoemTableViewCell.self,
                           forCellReuseIdentifier: PoemTableViewCell.reuseIdentifier)
        tableView.register(CouponTableViewCell.self,
                           forCellReuseIdentifier: CouponTableViewCell.reuseIdentifier)
    }
}

extension DivinationResultViewController: UITableViewDataSource, UITableViewDelegate {
    private enum DivinationCellType {
        case poem
        case coupon
        case prodcut

        func identifier() -> String {
            switch self {
            case .poem: return PoemTableViewCell.reuseIdentifier
            case .coupon: return CouponTableViewCell.reuseIdentifier
            case .prodcut: return PoemTableViewCell.reuseIdentifier
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = cellTypes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellType.identifier(), for: indexPath)
        switch cellType {
        case .poem:
            guard let cell = cell as? PoemTableViewCell else { return cell }
            cell.configure(with: "抽中大吉籤！", subtitle: "風恬浪靜可行舟 \n恰是中秋月一輪 \n凡事不須多憂慮 \n福祿自有慶家門")
            return cell
        case .coupon:
            guard let cell = cell as? CouponTableViewCell else { return cell }
            cell.configure(with: "獲得xx折價卷乙張",
                           couponNameText: "xx折價卷",
                           couponDiscountText: "$200",
                           couponExpirationDateText: "2023/06/10到期")
            return cell
        case .prodcut:
            return cell
        }
    }
}
