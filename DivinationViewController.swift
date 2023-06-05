//
//  Divination.swift
//  STYLiSH
//
//  Created by cleopatra on 2023/6/3.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import Foundation
import UIKit


class PickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    let genderArray = ["男性", "女性", "不分"]

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        genderArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = genderArray[row]
        label.textAlignment = .center
        return label
        
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        32
    }
    
}



class DivinationViewController: UIViewController, UITextFieldDelegate{
    
    let divinationTableView: UITableView = {
        let divinationTableView = UITableView()
        divinationTableView.separatorStyle = .none
        divinationTableView.separatorColor = .clear
        
        return divinationTableView
    }()
    let pickerViewController = PickerViewController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        divinationTableView.register(DivinationTitleTableViewCell.self, forCellReuseIdentifier: "\(DivinationTitleTableViewCell.self)")
        divinationTableView.register(GenderTableViewCell.self, forCellReuseIdentifier: "\(GenderTableViewCell.self)")
        divinationTableView.register(BirthdayTableViewCell.self, forCellReuseIdentifier: "\(BirthdayTableViewCell.self)")
        divinationTableView.register(ColorTableViewCell.self, forCellReuseIdentifier: "\(ColorTableViewCell.self)")
        divinationTableView.register(ButtonTableViewCell.self, forCellReuseIdentifier: "\(ButtonTableViewCell.self)")
   
        divinationTableView.delegate = self
        divinationTableView.dataSource = self
        self.addChild(pickerViewController)
        //隱藏
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.view.backgroundColor = .white
//        navigationController?.navigationBar.barTintColor = .white
        
        setTableView()
        
    }
    
    
    override func viewDidLayoutSubviews() {
        divinationTableView.separatorStyle = .none
    }
    
    
    func setTableView(){
        
        self.view.addSubview(divinationTableView)
        divinationTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            divinationTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            divinationTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            divinationTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            divinationTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
   
    
    @objc func postDivinationData(){
        
        var request = URLRequest(url: URL(string: "https://hyperushle.com/api/ios/divination")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let encoder = JSONEncoder()
        
        //轉換日期為 Date type
        let dateString = "[2022-02-22]"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dateString)
        
        let userImportData = STSuccessParser(data:DivinationUserRequestBody(birthday: dateString, sign: "userTest", gender: "unisex", color: "#CCCCCC"), paging: nil)
        let data = try? encoder.encode(userImportData)

        
        request.httpMethod = "POST"
        request.httpBody = data
        
        // Set httpBody
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data {
                
                let content = String(data: data, encoding: .utf8) ?? ""
                
                    do {
                        let decoder = JSONDecoder()
                        let divinationResponse = try decoder.decode(STSuccessParser<DivinationUserPostResponse>.self, from: data)
                     
                    } catch  {
                        print(error)
                    }
                }
        }

        task.resume()

        
        //Click 占卜 button 後跳轉下一個畫面
        let DivinationResultVC = DivinationResultViewController()
        DivinationResultVC.view.backgroundColor = .white
        navigationController?.pushViewController(DivinationResultVC, animated: true)
    }
    
    
    
}



extension DivinationViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(DivinationTitleTableViewCell.self)", for: indexPath)
            guard let titleCell = cell as? DivinationTitleTableViewCell else { return cell }
                
            titleCell.pageTitleLabel.text = "優惠占卜"
            titleCell.divinationImageView.image = UIImage(named: "draw.png")
//            titleCell.divinationImageView.contentMode = .scaleAspectFit
            titleCell.layoutCell()
            
            // 加入 gif 圖
//            if let url = Bundle.main.url(forResource: "draw", withExtension: "gif"){
//                let cfUrl = url as CFURL
//                CGAnimateImageAtURLWithBlock(cfUrl, nil) { (_, cgImage, _) in
//                    titleCell.divinationImageView.image = UIImage(cgImage: cgImage)
//                    return
//                }
//            }
            
            titleCell.selectionStyle = .none
            
            return titleCell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(GenderTableViewCell.self)", for: indexPath)
            guard let genderCell = cell as? GenderTableViewCell else { return cell }
            
            genderCell.genderLabel.text = "性別"
            genderCell.layoutCell()
            genderCell.genderPicker.delegate = pickerViewController 
            genderCell.genderPicker.dataSource = pickerViewController
            genderCell.selectionStyle = .none
            return genderCell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(BirthdayTableViewCell.self)", for: indexPath)
            guard let birthdayCell = cell as? BirthdayTableViewCell else { return cell }
            
            birthdayCell.birthdayLabel.text = "生辰日"
            birthdayCell.constellationLabel.text = "星座"
            birthdayCell.layoutCell()
            birthdayCell.birthdayTextField.delegate = self
            birthdayCell.selectionStyle = .none
            
            return birthdayCell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(ColorTableViewCell.self)", for: indexPath)
            guard let colorCell = cell as? ColorTableViewCell else { return cell }
            let arrayOfColor = ["#bec5fd", "#97bcb7", "#f9b4f6", "#bec5fd", "#a5be95"]
            
            colorCell.colorLabel.text = "偏好顏色"
            colorCell.layoutColorBall(arrayOfColor: arrayOfColor)
            colorCell.layoutCell()
            colorCell.selectionStyle = .none
            
            return colorCell
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(ButtonTableViewCell.self)", for: indexPath)
            guard let buttonCell = cell as? ButtonTableViewCell else { return cell }
            
            buttonCell.divinationButton.setTitle("開始占卜", for: .normal)
            buttonCell.layoutCell()
            buttonCell.selectionStyle = .none
            buttonCell.divinationButton.addTarget(self, action: #selector(postDivinationData), for: .touchUpInside)
            
            return buttonCell
            
        default:
            //??
            return tableView.dequeueReusableCell(withIdentifier: "\(DivinationTitleTableViewCell.self)", for: indexPath)
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row{
        case 1:
            return 120
        default:
            return UITableView.automaticDimension
        }
    }

    
}

