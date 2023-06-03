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
    
    var data: DivinationData? {
        didSet {
            DispatchQueue.main.async { [unowned self] in
                tableView.reloadData()
            }
        }
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
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
        tableView.register(RecommendedProductTableViewCell.self,
                           forCellReuseIdentifier: RecommendedProductTableViewCell.reuseIdentifier)
        
        DivinationProvider.shared.fetchDivinationResult { [weak self] data in
            guard let self = self else { return }
            self.data = data
            print(data)
        }
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
            case .prodcut: return RecommendedProductTableViewCell.reuseIdentifier
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellType = cellTypes[indexPath.row]
        switch cellType {
        case .prodcut: return 400
        default: return UITableView.automaticDimension
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = cellTypes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellType.identifier(), for: indexPath)
        cell.selectionStyle = .none
        guard let data = self.data else { return cell }
        switch cellType {
        case .poem:
            guard let cell = cell as? PoemTableViewCell else { return cell }
            cell.configure(with: "抽中\(data.strawsStory.type)！",
                           subtitle: data.strawsStory.story) //"風恬浪靜可行舟， \n恰是中秋月一輪，\n凡事不須多憂慮， \n福祿自有慶家門。")
            return cell
        case .coupon:
            guard let cell = cell as? CouponTableViewCell else { return cell }
            let validDate = data.validDate.split(separator: " ")[0]
            
            cell.configure(with: "獲得\(data.couponName)折價卷乙張",
                           couponNameText: "\(data.description)折價卷",
                           couponDiscountText: "$\(data.discount)",
                           couponExpirationDateText: "\(validDate)到期")
            return cell
        case .prodcut:
            guard let cell = cell as? RecommendedProductTableViewCell else { return cell }
            cell.data = data.products
            cell.showDetailPage = { [weak self] (indexPath) -> Void in
                guard
                    let self = self,
                    let detailVC = UIStoryboard.product.instantiateViewController(
                        withIdentifier: String(describing: ProductDetailViewController.self)
                    ) as? ProductDetailViewController
                else {
                    return
                }
                detailVC.product = data.products[indexPath.row]
                detailVC.modalTransitionStyle = .coverVertical
                show(detailVC, sender: nil)
            }
            return cell
        }
    }
}
