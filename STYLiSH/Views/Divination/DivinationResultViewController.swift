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
    private let userProvider = UserProvider()
    
    var data: DivinationData?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var couponView: CouponView = {
        let view = CouponView()
        view.isHidden = true
        if KeyChainManager.shared.token == nil { view.toggle(isSignedIn: false) } else { view.toggle(isSignedIn: true) }
        
        view.dismissView = {
            view.isHidden = true
        }
        
        view.popToRootView = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
            //self?.tabBarController?.selectedViewController = self?.tabBarController?.viewControllers![0]
        }
        
        view.loginToFacebook = { [weak self] in
            guard let self = self else { return }
            userProvider.loginWithFaceBook(from: self, completion: { [weak self] result in
                switch result {
                case .success(let token):
                    self?.onSTYLiSHSignIn(token: token)
                    DispatchQueue.main.async {
                        view.isHidden = true
                    }
                case .failure:
                    LKProgressHUD.showSuccess(text: "Facebook 登入失敗!")
                }
            })
        }
        return view
    }()
    
    // MARK: - View Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Add the table view to the view controller's view
        view.addSubview(tableView)
        view.addSubview(couponView)
        
        // Set up the table view constraints
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            couponView.topAnchor.constraint(equalTo: view.topAnchor),
            couponView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            couponView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            couponView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
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
    }
    
    private func onSTYLiSHSignIn(token: String) {
        LKProgressHUD.show()

        userProvider.signInToSTYLiSH(fbToken: token, completion: { [weak self] result in
            LKProgressHUD.dismiss()

            switch result {
            case .success:
                LKProgressHUD.showSuccess(text: "STYLiSH 登入成功")
                // Log in success
                self?.sendCouponPost()
            case .failure:
                LKProgressHUD.showSuccess(text: "STYLiSH 登入失敗!")
            }
            DispatchQueue.main.async {
                self?.presentingViewController?.dismiss(animated: false, completion: nil)
            }
        })
    }
    
    private func sendCouponPost() {
        guard let couponId = data?.couponId else { return }
        DivinationProvider.shared.sendCouponId(couponId: couponId) { [weak self] statusCode, data in
            if statusCode == 403 {
                DispatchQueue.main.async {
                    self?.couponView.toggle(isSignedIn: true)
                    self?.couponView.changeTitleLabel(with: data)
                    self?.couponView.isHidden = false
                }
            } else if statusCode == 200 {
                DispatchQueue.main.async {
                    self?.couponView.toggle(isSignedIn: true)
                    self?.couponView.isHidden = false
                }
            }
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
        case .poem: return 200
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
                           subtitle: data.strawsStory.story)
            return cell
        case .coupon:
            guard let cell = cell as? CouponTableViewCell else { return cell }
            cell.configure(with: data.couponName,
                           couponDiscountText: data.discount,
                           couponExpirationDateText: data.validDate)
            cell.popViewController = { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            cell.showPopUpView = { [weak self] in
                if KeyChainManager.shared.token == nil { self?.couponView.isHidden = false }
                self?.sendCouponPost()
            }
            return cell
        case .prodcut:
            guard let cell = cell as? RecommendedProductTableViewCell else { return cell }
            cell.data = data.products
            cell.showDetailPage = { [weak self] (indexPath) -> Void in
                guard let self = self,
                      let detailVC = UIStoryboard.product.instantiateViewController(
                            withIdentifier: String(describing: ProductDetailViewController.self)
                      ) as? ProductDetailViewController
                else { return }
                detailVC.product = data.products[indexPath.row]
                show(detailVC, sender: nil)
            }
            return cell
        }
    }
}
