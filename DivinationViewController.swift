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
    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        switch (row, component){
//        case (0, 0):
//            return genderArray[row]
//        case (1, 0):
//            return genderArray[row]
//        case (2, 0):
//            return genderArray[row]
//        default:
//            return "無"
//        }
//    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        32
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title = genderArray[row]
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 10) // 设置字体大小为 20
        ]
        return NSAttributedString(string: title, attributes: attributes)
    }
    
}



class DivinationViewController: UIViewController{
    
    let divinationTableView = UITableView()
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
        
        setTableView()
        
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
            
            return titleCell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(GenderTableViewCell.self)", for: indexPath)
            guard let genderCell = cell as? GenderTableViewCell else { return cell }
            
            genderCell.genderLabel.text = "性別"
            genderCell.layoutCell()
            genderCell.genderPicker.delegate = pickerViewController 
            genderCell.genderPicker.dataSource = pickerViewController
            return genderCell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(BirthdayTableViewCell.self)", for: indexPath)
            guard let birthdayCell = cell as? BirthdayTableViewCell else { return cell }
            
            birthdayCell.birthdayLabel.text = "生辰日"
            birthdayCell.constellationLabel.text = "星座"
            birthdayCell.layoutCell()
            birthdayCell.birthdayTextField.delegate = self
            
            return birthdayCell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(ColorTableViewCell.self)", for: indexPath)
            guard let colorCell = cell as? ColorTableViewCell else { return cell }
            let arrayOfColor = ["#bec5fd", "#97bcb7", "#f9b4f6", "#bec5fd", "#a5be95"]
            
            colorCell.colorLabel.text = "偏好顏色"
            colorCell.layoutColorBall(arrayOfColor: arrayOfColor)
            colorCell.layoutCell()
            
            return colorCell
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(ButtonTableViewCell.self)", for: indexPath)
            guard let buttonCell = cell as? ButtonTableViewCell else { return cell }
            
            buttonCell.divinationButton.setTitle("開始占卜", for: .normal)
            buttonCell.layoutCell()
            
            return buttonCell
            
        default:
            //??
            return tableView.dequeueReusableCell(withIdentifier: "\(DivinationTitleTableViewCell.self)", for: indexPath)
        }
        
        
    }

    
}


extension DivinationViewController: UITextFieldDelegate{
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//
//    }
    
}
