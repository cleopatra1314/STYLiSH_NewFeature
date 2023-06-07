//
//  ChatBotViewController.swift
//  Pods
//
//  Created by cleopatra on 2023/6/5.
//

import Foundation
import UIKit
import Kingfisher


class ChatBotViewController: STBaseViewController{
    
    let socket = WebSocket.shared
    
    var dataTypeArray = ["default1", "default2"]
    var dataResult: [Product] = []
    
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
    
    @objc func sendButtonTapped() {
        guard let text = typingTextField.text,
              !(text.isEmpty) else { return }
        print(text)
        socket.socketEmit(with: text)
        typingTextField.text = ""
        dataTypeArray.append("userReplyWithText")
        dataResult.append(Product(id: 0, title: text, description: "", price: 0, texture: "", wash: "", place: "", note: "", story: "", colors: [], sizes: [], variants: [], mainImage: "", images: []))
        chatBotTableView.reloadData()
        chatBotTableView.scrollToRow(at: IndexPath(row: dataTypeArray.count - 1, section: 0), at: .bottom, animated: true)
    }
    
    lazy var bottomCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        //section的間距
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        //cell間距
        layout.minimumLineSpacing = 10
        //cell 長寬
//        layout.itemSize = CGSize(width: 100, height: 30)
        //滑動的方向
        layout.scrollDirection = .horizontal
        //以 auto layout 計算 cell 大小
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        
        //collectionView frame設定 x,y,寬,高
        let bottomCollectionView = UICollectionView(frame: CGRect(x: 0, y: 400, width: 300, height: 50),collectionViewLayout: layout)
        //背景顏色
        bottomCollectionView.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        //你所註冊的cell
        bottomCollectionView.register(ChatBotBottomCollectionViewCell.self, forCellWithReuseIdentifier: "\(ChatBotBottomCollectionViewCell.self)")
        
        bottomCollectionView.delegate = self
        bottomCollectionView.dataSource = self
        
        return bottomCollectionView
    }()
    let canMessageTitleArray = ["推薦洋裝👗", "推薦牛仔褲👖", "熱門推薦🔥", "最新流行✨", "優惠活動詢問🎁"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = nil
        
        chatBotTableView.delegate = self
        chatBotTableView.dataSource = self
        WebSocket.shared.delegate = self
        
        view.backgroundColor = .white
        setNav()
        setTypingArea()
        setCollectionView()
        setTableView()
        
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        
        chatBotTableView.register(ChatBotTableViewCell.self, forCellReuseIdentifier: "\(ChatBotTableViewCell.self)")
        
        if #available(iOS 14.0, *) {
            navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: UIAction(handler: { [weak self] _ in
                self?.socket.socketEmitFromAdmin()
            }))
        }
    }
    

    override func viewWillLayoutSubviews() {
        typingTextField.layer.cornerRadius = typingTextField.frame.height / 2
    }
    
    
    func setNav(){
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 79/255, green: 79/255, blue: 79/255, alpha: 1)
        let closeBtn = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeBtn))
        closeBtn.tintColor = .white
        self.navigationItem.leftBarButtonItem = closeBtn
//        self.navigationItem.titleView = UIImageView(image: UIImage(named: "Icon_chatbot.png"))
        
        
        self.navigationItem.titleView?.contentMode = .scaleAspectFit
        self.navigationItem.titleView?.tintColor = .green
        let topView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        let topTitleLabel = UILabel(frame: CGRect(x: 44, y: 0, width: 100, height: 40))
        let TopBarImageView = UIImageView(image: UIImage(named: "Icon_chatbot.png"))
        topView.addSubview(TopBarImageView)
        topView.addSubview(topTitleLabel)
        TopBarImageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        
        topTitleLabel.text = "智能小幫手"
        topTitleLabel.font = UIFont(name: "PingFangTC-medium", size: 18)
        topTitleLabel.textColor = .white
        self.navigationItem.titleView = topView
    }
    
    
    @objc func closeBtn(){
        dismiss(animated: true)
    }
    
    
    func setTableView(){
        
        chatBotTableView.register(DressTableViewCell.self, forCellReuseIdentifier: "\(DressTableViewCell.self)")
        chatBotTableView.register(PromotionTableViewCell.self, forCellReuseIdentifier: "\(PromotionTableViewCell.self)")
        chatBotTableView.register(UserChatTableViewCell.self, forCellReuseIdentifier: "\(UserChatTableViewCell.self)")
        
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
            
            cell.dialogTextView.attributedText = NSMutableAttributedString(string: "早安～我是你的購物小幫手，同時也是一個精通時尚的機器人哦！", attributes: [NSAttributedString.Key.font: UIFont(name: "PingFangTC-Regular", size: 15), NSAttributedString.Key.kern: 1.6, NSAttributedString.Key.foregroundColor: UIColor(red: 79/255, green: 79/255, blue: 79/255, alpha: 1)])
            
            cell.layoutCell()
            return cell
            
        case "default2":
            let cell = ChatBotTableViewCell.init(style: .default, reuseIdentifier: nil)

            cell.dialogTextView.attributedText = NSMutableAttributedString(string: "有什麼可以為你服務的嗎？", attributes: [NSAttributedString.Key.font: UIFont(name: "PingFangTC-Regular", size: 15), NSAttributedString.Key.kern: 1.6, NSAttributedString.Key.foregroundColor: UIColor(red: 79/255, green: 79/255, blue: 79/255, alpha: 1)])
            cell.layoutCell()
            return cell
        
        case "adminMessage":
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(ChatBotTableViewCell.self)", for: indexPath) as! ChatBotTableViewCell
            cell.dialogTextView.attributedText = NSMutableAttributedString(string: dataResult[indexPath.row - 2].title, attributes: [NSAttributedString.Key.font: UIFont(name: "PingFangTC-Regular", size: 15), NSAttributedString.Key.kern: 1.6, NSAttributedString.Key.foregroundColor: UIColor(red: 79/255, green: 79/255, blue: 79/255, alpha: 1)])
            cell.layoutCell()
            return cell
            
        case "divination":
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(PromotionTableViewCell.self)", for: indexPath) as! PromotionTableViewCell
//            cell.itemImageView.kf.setImage(with: URL(string: dataResult[indexPath.item - 2].image))
            cell.layoutCell()
            cell.goToDivinationClosure = { cell in
//                let divinationVC = self.tabBarController?.viewControllers[2]
//                self.navigationController?.popToViewController(<#T##UIViewController#>, animated: <#T##Bool#>)
            }
            return cell
            
        case "dress", "jeans", "hots", "new":
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(DressTableViewCell.self)", for: indexPath) as! DressTableViewCell
//            if dataType == "dress"{
                //因為有兩筆預設訊息資料 (dataTypeArray)，所以 dataResult array - 2
//                cell.itemTitlelabel.text = dataResult[indexPath.item - 2].title
                cell.itemImageView.kf.setImage(with: URL(string: dataResult[indexPath.item - 2].mainImage))
                cell.itemTitlelabel.attributedText = NSMutableAttributedString(string: dataResult[indexPath.item - 2].title, attributes: [NSAttributedString.Key.font: UIFont(name: "PingFangTC-Medium", size: 15), NSAttributedString.Key.kern: 1.6, NSAttributedString.Key.foregroundColor: UIColor(red: 79/255, green: 79/255, blue: 79/255, alpha: 1)])
//            }else if dataType == "jeans"{
//                cell.itemTitlelabel.text = dataResult[indexPath.item - 2].title
//                cell.itemImageView.kf.setImage(with: URL(string: dataResult[indexPath.item - 2].mainImage))
//            }else if dataType == "hots"{
//                cell.itemTitlelabel.text = dataResult[indexPath.item - 2].title
//                cell.itemImageView.kf.setImage(with: URL(string: dataResult[indexPath.item - 2].mainImage))
//            }else{
//                cell.itemTitlelabel.text = dataResult[indexPath.item - 2].title
//                cell.itemImageView.kf.setImage(with: URL(string: dataResult[indexPath.item - 2].mainImage))
//            }
            cell.layoutCell()
            return cell
            
        case "userReplyForDress", "userReplyForJeans", "userReplyForHots", "userReplyForNew", "userReplyForDivination", "userReplyWithText":
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(UserChatTableViewCell.self)", for: indexPath) as! UserChatTableViewCell
            if dataType == "userReplyForDress"{
                cell.dialogTextView.attributedText = NSMutableAttributedString(string: "推我洋裝", attributes: [NSAttributedString.Key.font: UIFont(name: "PingFangTC-Regular", size: 15), NSAttributedString.Key.kern: 1.6, NSAttributedString.Key.foregroundColor: UIColor.white])
            
            }else if dataType == "userReplyForJeans"{
                cell.dialogTextView.attributedText = NSMutableAttributedString(string: "推我牛仔褲", attributes: [NSAttributedString.Key.font: UIFont(name: "PingFangTC-Regular", size: 15), NSAttributedString.Key.kern: 1.6, NSAttributedString.Key.foregroundColor: UIColor.white])
               
            }else if dataType == "userReplyForHots"{
                cell.dialogTextView.attributedText = NSMutableAttributedString(string: "我要熱門", attributes: [NSAttributedString.Key.font: UIFont(name: "PingFangTC-Regular", size: 15), NSAttributedString.Key.kern: 1.6, NSAttributedString.Key.foregroundColor: UIColor.white])
              
            }else if dataType == "userReplyForNew"{
                cell.dialogTextView.attributedText = NSMutableAttributedString(string: "給我新品", attributes: [NSAttributedString.Key.font: UIFont(name: "PingFangTC-Regular", size: 15), NSAttributedString.Key.kern: 1.6, NSAttributedString.Key.foregroundColor: UIColor.white])
                
            } else if dataType == "userReplyWithText" {
                cell.dialogTextView.attributedText = NSMutableAttributedString(string: dataResult[indexPath.row - 2].title, attributes: [NSAttributedString.Key.font: UIFont(name: "PingFangTC-Regular", size: 15), NSAttributedString.Key.kern: 1.6, NSAttributedString.Key.foregroundColor: UIColor.white])
            } else {
                cell.dialogTextView.attributedText = NSMutableAttributedString(string: "給我優惠", attributes: [NSAttributedString.Key.font: UIFont(name: "PingFangTC-Regular", size: 15), NSAttributedString.Key.kern: 1.6, NSAttributedString.Key.foregroundColor: UIColor.white])
                
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
//        cell.canMessageButton.setTitle(canMessageTitleArray[indexPath.item], for: .normal)
        cell.titleOfButtonLabel.text = canMessageTitleArray[indexPath.item]
        cell.layoutCell()
        
        cell.twitClosure = { collectionViewCell in
            let indexOfSelectedCanMessage = self.bottomCollectionView.indexPath(for: collectionViewCell)
            var parameter: STSuccessParser<DataOfChatBotSenderType>?
    
            if indexOfSelectedCanMessage?.item == 0{
                self.dataTypeArray += [ChatBotSenderType.userReplyForDress.rawValue, ChatBotSenderType.dress.rawValue]
                let parameters = STSuccessParser<DataOfChatBotSenderType>(data: DataOfChatBotSenderType(type: "dress"), paging: nil)
                parameter = parameters
                
            }else if indexOfSelectedCanMessage?.item == 1{
                self.dataTypeArray.append(ChatBotSenderType.userReplyForJeans.rawValue)
                self.dataTypeArray.append(ChatBotSenderType.jeans.rawValue)
                let parameters = STSuccessParser<DataOfChatBotSenderType>(data: DataOfChatBotSenderType(type: "jeans"), paging: nil)
                parameter = parameters
                
            }else if indexOfSelectedCanMessage?.item == 2{
                self.dataTypeArray.append(ChatBotSenderType.userReplyForHots.rawValue)
                self.dataTypeArray.append(ChatBotSenderType.hots.rawValue)
                let parameters = STSuccessParser<DataOfChatBotSenderType>(data: DataOfChatBotSenderType(type: "hots"), paging: nil)
                parameter = parameters
                
            }else if indexOfSelectedCanMessage?.item == 3{
                self.dataTypeArray.append(ChatBotSenderType.userReplyForNew.rawValue)
                self.dataTypeArray.append(ChatBotSenderType.new.rawValue)
                let parameters = STSuccessParser<DataOfChatBotSenderType>(data: DataOfChatBotSenderType(type: "new"), paging: nil)
                parameter = parameters
                
            }else{
                self.dataTypeArray.append(ChatBotSenderType.userReplyForDivination.rawValue)
                self.dataTypeArray.append(ChatBotSenderType.divination.rawValue)
                let parameters = STSuccessParser<DataOfChatBotSenderType>(data: DataOfChatBotSenderType(type: "divination"), paging: nil)
                parameter = parameters
                
            }
            
            //串接 post api
//                let postData = parameters.data(using: .utf8)
            let postData = try? JSONEncoder().encode(parameter)

            var request = URLRequest(url: URL(string: "https://hyperushle.com/api/ios/chatbox")!,timeoutInterval: Double.infinity)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            request.httpMethod = "POST"
            request.httpBody = postData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    print(String(describing: error))
                    return
                }
                print("拿到的資料為 \(String(data: data, encoding: .utf8)!)")
                
                do{
                    let result = try JSONDecoder().decode(STSuccessParser<Product>.self, from: data)
                    self.dataResult += [result.data, result.data]
                    
                    DispatchQueue.main.async {
                        self.chatBotTableView.reloadData()
                    }
                    
                }catch{
                    print(error)
                }
                
            }.resume()
                            
            print("目前的 dataTypeArray 為 \(self.dataTypeArray)")
            
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

extension ChatBotViewController: WebSocketDelegate {
    func pass(adminMessages: [Message]) {
        for message in adminMessages {
            dataTypeArray.append("adminMessage")
            dataResult.append(Product(id: 0, title: message.message, description: "", price: 0, texture: "", wash: "", place: "", note: "", story: "", colors: [], sizes: [], variants: [], mainImage: "", images: []))
        }
        chatBotTableView.reloadData()
        chatBotTableView.scrollToRow(at: IndexPath(row: dataTypeArray.count - 1, section: 0), at: .bottom, animated: true)
    }
}
