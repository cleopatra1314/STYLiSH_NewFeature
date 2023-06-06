//
//  ChatBotViewController.swift
//  Pods
//
//  Created by cleopatra on 2023/6/5.
//

import Foundation
import UIKit


class ChatBotViewController: STBaseViewController{
    
    var dataTypeArray = ["default1", "default2"]
    
    let chatBotTableView: UITableView = {
        let chatBotTableView = UITableView()
        chatBotTableView.separatorStyle = .none
        return chatBotTableView
    }()
    let typingAreaView: UIView = {
        let typingAreaView = UIView()
        typingAreaView.backgroundColor = .white
        typingAreaView.layer.shadowOpacity = 0.5
        typingAreaView.layer.shadowOffset = CGSizeMake(0, -4)
        typingAreaView.layer.shadowRadius = 10
        
        return typingAreaView
    }()
    let typingTextField: UITextField = {
        let typingTextField = UITextField()
        typingTextField.backgroundColor = UIColor(cgColor: CGColor(red: 232/255, green: 232/255, blue: 232/255, alpha: 1))
//        typingTextField.layer.cornerRadius = 16
        
        return typingTextField
    }()
    let sendButton: UIButton = {
        let sendButton = UIButton()
//        sendButton.setImage(UIImage(systemName: "paperplane"), for: .normal)
//        sendButton.setImage(UIImage(systemName: "paperplane.fill"), for: .highlighted)
        sendButton.setBackgroundImage(UIImage(systemName: "paperplane"), for: .normal)
        sendButton.setBackgroundImage(UIImage(systemName: "paperplane.fill"), for: .highlighted)
        sendButton.tintColor = .black
        
        return sendButton
    }()
    lazy var bottomCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        //section的間距
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        //cell間距
        layout.minimumLineSpacing = 5
        //cell 長寬
//        layout.itemSize = CGSize(width: 100, height: 30)
        //滑動的方向
        layout.scrollDirection = .horizontal
        //以 auto layout 計算 cell 大小
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        
        //collectionView frame設定 x,y,寬,高
        let bottomCollectionView = UICollectionView(frame: CGRect(x: 0, y: 400, width: 300, height: 50),collectionViewLayout: layout)
        //背景顏色
        bottomCollectionView.backgroundColor = UIColor.lightGray
        //你所註冊的cell
        bottomCollectionView.register(ChatBotBottomCollectionViewCell.self, forCellWithReuseIdentifier: "\(ChatBotBottomCollectionViewCell.self)")
        
        bottomCollectionView.delegate = self
        bottomCollectionView.dataSource = self
        
        return bottomCollectionView
    }()
    let canMessageTitleArray = ["推薦洋裝", "推薦牛仔褲", "熱門推薦", "優惠活動詢問", "最新流行",]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatBotTableView.delegate = self
        chatBotTableView.dataSource = self
        
        view.backgroundColor = .white
        setNav()
        setTypingArea()
        setCollectionView()
        setTableView()
    }
    

    override func viewWillLayoutSubviews() {
        typingTextField.layer.cornerRadius = typingTextField.frame.height / 2
    }
    
    
    func setNav(){
        self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController?.navigationBar.backgroundColor = UIColor(ciColor: CIColor(red: 1, green: 1, blue: 1, alpha: 0.2))
        self.navigationController?.navigationBar.backgroundColor = .blue
        let closeBtn = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeBtn))
        closeBtn.tintColor = .black
        self.navigationItem.leftBarButtonItem = closeBtn
//        self.navigationItem.titleView = UIImageView(image: UIImage(named: "Icon_chatbot.png"))
        
        
        self.navigationItem.titleView?.contentMode = .scaleAspectFit
        let topView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        let topTitleLabel = UILabel(frame: CGRect(x: 44, y: 0, width: 100, height: 40))
        let TopBarImageView = UIImageView(image: UIImage(named: "Icon_chatbot.png"))
        topView.addSubview(TopBarImageView)
        topView.addSubview(topTitleLabel)
        TopBarImageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        topTitleLabel.text = "智能小幫手"
//        TopBarImageView.translatesAutoresizingMaskIntoConstraints = false
//        topTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.navigationItem.titleView = topView
    }
    
    
    @objc func closeBtn(){
        dismiss(animated: true)
    }
    
    
    func setTableView(){
        
        chatBotTableView.register(DressTableViewCell.self, forCellReuseIdentifier: "\(DressTableViewCell.self)")
        chatBotTableView.register(PromotionTableViewCell.self, forCellReuseIdentifier: "\(PromotionTableViewCell.self)")
        
        self.view.addSubview(chatBotTableView)
        
        chatBotTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chatBotTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            chatBotTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            chatBotTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            chatBotTableView.bottomAnchor.constraint(equalTo: bottomCollectionView.topAnchor)
        ])
    }
    
    
    func setTypingArea(){
        
        self.view.addSubview(typingAreaView)
        typingAreaView.addSubview(typingTextField)
        typingAreaView.addSubview(sendButton)
        
        typingAreaView.translatesAutoresizingMaskIntoConstraints = false
        typingTextField.translatesAutoresizingMaskIntoConstraints = false
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            typingAreaView.topAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -94),
            typingAreaView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            typingAreaView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            typingAreaView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            typingTextField.leadingAnchor.constraint(equalTo: typingAreaView.leadingAnchor, constant: 16),
            typingTextField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -16),
            typingTextField.topAnchor.constraint(equalTo: typingAreaView.topAnchor, constant: 12),
            typingTextField.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            sendButton.trailingAnchor.constraint(equalTo: typingAreaView.trailingAnchor, constant: -16),
//            sendButton.topAnchor.constraint(equalTo: typingAreaView.topAnchor, constant: 8),
//            sendButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            sendButton.centerYAnchor.constraint(equalTo: typingTextField.centerYAnchor),
            sendButton.heightAnchor.constraint(equalToConstant: 28),
            sendButton.widthAnchor.constraint(equalTo: sendButton.heightAnchor, multiplier: 1)
        ])
        
    }
    
    
    func setCollectionView(){
        
        self.view.addSubview(bottomCollectionView)
        
        bottomCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomCollectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            bottomCollectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            bottomCollectionView.bottomAnchor.constraint(equalTo: typingAreaView.topAnchor),
            bottomCollectionView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
    }
    
    
}


extension ChatBotViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataTypeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dataType = dataTypeArray[indexPath.item]
        
        switch dataType {
        case "default1":
            let cell = ChatBotTableViewCell.init(style: .default, reuseIdentifier: nil)
            cell.dialogTextView.text = "早安～我是你的購物小幫手，同時也是一個精通時尚的機器人哦！早安～我是你的購物小幫手，同時也是一個精通時尚的機器人哦！早安～我是你的購物小幫手，同時也是一個精通時尚的機器人哦！"
            cell.layoutCell()
            return cell
            
        case "default2":
            let cell = ChatBotTableViewCell.init(style: .default, reuseIdentifier: nil)
            cell.dialogTextView.text = "有什麼可以為你服務的嗎？"
            cell.layoutCell()
            return cell
            
        case "divination":
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(PromotionTableViewCell.self)", for: indexPath) as! PromotionTableViewCell
            cell.itemImageView.image = UIImage(named: "orton.jpg")
            cell.layoutCell()
            return cell
            
        case "dress", "jeans", "hots", "new":
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(DressTableViewCell.self)", for: indexPath) as! DressTableViewCell
            if dataType == "dress"{
                cell.itemTitlelabel.text = "洋裝"
                cell.itemImageView.image = UIImage(named: "orton.jpg")
            }else if dataType == "jeans"{
                cell.itemTitlelabel.text = "牛仔褲"
                cell.itemImageView.image = UIImage(named: "orton.jpg")
            }else if dataType == "hots"{
                cell.itemTitlelabel.text = "熱門"
                cell.itemImageView.image = UIImage(named: "orton.jpg")
            }else{
                cell.itemTitlelabel.text = "新品"
                cell.itemImageView.image = UIImage(named: "orton.jpg")
            }
            cell.layoutCell()
            return cell
            
        default:
            //TODO: 待修改
            let cell = ChatBotTableViewCell.init(style: .default, reuseIdentifier: nil)
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if newTableView.backgroundColor == UIColor.white {
//            newTableView.backgroundColor = UIColor.black
//        } else if newTableView.backgroundColor == UIColor.black {
//            newTableView.backgroundColor = UIColor.white
//        }
    }
    
    
}


extension ChatBotViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5;
    }

    //cell 顯示控制
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ChatBotBottomCollectionViewCell.self)", for: indexPath) as! ChatBotBottomCollectionViewCell
        cell.canMessageButton.setTitle(canMessageTitleArray[indexPath.item], for: .normal)
        cell.layoutCell()
        
        cell.twitClosure = { collectionViewCell in
            let indexOfSelectedCanMessage = self.bottomCollectionView.indexPath(for: collectionViewCell)
            
            switch indexOfSelectedCanMessage?.item{
            case 0:
                self.dataTypeArray.append(ChatBotSenderType.dress.rawValue)
            case 1:
                self.dataTypeArray.append(ChatBotSenderType.jeans.rawValue)
            case 2:
                self.dataTypeArray.append(ChatBotSenderType.hots.rawValue)
            case 3:
                self.dataTypeArray.append(ChatBotSenderType.new.rawValue)
            case 4:
                self.dataTypeArray.append(ChatBotSenderType.divination.rawValue)
            default:
                return
            }
            self.chatBotTableView.reloadData()
            print(self.dataTypeArray)
        }
        
        return cell
    }

    //sections數量
    func numberOfSectionsInCollectionView(
        collectionView: UICollectionView) -> Int {
        return 1
    }

    //點擊事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("你選擇了第 \(indexPath.section + 1) 組的")
        print("第 \(indexPath.item + 1) ")
    }
    
}
