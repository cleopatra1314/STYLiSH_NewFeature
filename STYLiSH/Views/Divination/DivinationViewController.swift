//
//  Divination.swift
//  STYLiSH
//
//  Created by cleopatra on 2023/6/3.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import Foundation
import UIKit

class DivinationViewController: UIViewController, UITextFieldDelegate{
    
    let divinationTableView: UITableView = {
        let divinationTableView = UITableView()
        divinationTableView.separatorStyle = .none
        divinationTableView.separatorColor = .clear
        
        return divinationTableView
    }()

    //Info selected by user
    var selectedColorHex: String?
    var selectedDateString: String?
    var selectedGender: String = Gender.男性.getGender()
    var selectedConstellation: String?
    let genderArray: [Gender] = [.男性, .女性, .不分]
    let arrayOfColor = ["#DDF0FF", "#DDFFBB", "#CCCCCC", "#334455", "#BB7744"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        divinationTableView.register(DivinationTitleTableViewCell.self, forCellReuseIdentifier: "\(DivinationTitleTableViewCell.self)")
        divinationTableView.register(GenderTableViewCell.self, forCellReuseIdentifier: "\(GenderTableViewCell.self)")
        divinationTableView.register(BirthdayTableViewCell.self, forCellReuseIdentifier: "\(BirthdayTableViewCell.self)")
        divinationTableView.register(ColorTableViewCell.self, forCellReuseIdentifier: "\(ColorTableViewCell.self)")
        divinationTableView.register(ButtonTableViewCell.self, forCellReuseIdentifier: "\(ButtonTableViewCell.self)")
   
        divinationTableView.delegate = self
        divinationTableView.dataSource = self

        //隱藏 navigation bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.view.backgroundColor = .white
        
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
        
        //取得 cell 輸入的日期資訊
        let dateCell = divinationTableView.cellForRow(at: IndexPath(row: 2, section: 0)) as! BirthdayTableViewCell
        selectedDateString = dateCell.selectedDateString
        selectedConstellation = dateCell.selectedConstellation
        
        guard let selectedDateString = selectedDateString,
              let selectedConstellation = selectedConstellation else { print("birthday is nil") ; return }
        
        //取得 cell 輸入的顏色資訊
        let colorCell = divinationTableView.cellForRow(at: IndexPath(row: 3, section: 0)) as! ColorTableViewCell
        guard let indexOfSelectedColor = colorCell.indexOfSelectedColor else { print("color is nil") ; return }
        let selectedColorHex = arrayOfColor[indexOfSelectedColor]
        
        let userImportData = STSuccessParser(data: DivinationRequestBody(birthday: selectedDateString,
                                                                         sign: selectedConstellation,
                                                                         gender: selectedGender,
                                                                         color: selectedColorHex), paging: nil)
        
        DivinationProvider.shared.fetchDivinationResult(requestBody: userImportData) { [weak self] data in
            DispatchQueue.main.async {
                let DivinationResultVC = DivinationResultViewController()
                DivinationResultVC.data = data
                self?.navigationController?.pushViewController(DivinationResultVC, animated: true)
            }
        }
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
            titleCell.layoutCell()
            titleCell.selectionStyle = .none
            
            return titleCell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(GenderTableViewCell.self)", for: indexPath)
            guard let genderCell = cell as? GenderTableViewCell else { return cell }
            
            genderCell.genderLabel.text = "性別"
            genderCell.layoutCell()
            genderCell.genderPicker.delegate = self
            genderCell.genderPicker.dataSource = self
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
            
        default: return tableView.dequeueReusableCell(withIdentifier: "\(DivinationTitleTableViewCell.self)", for: indexPath)
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


extension DivinationViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    enum Gender: String{
        case 男性
        case 女性
        case 不分
        
        func getGender() -> String{
            switch self{
            case .男性:
                return "men"
            case .女性:
                return "women"
            case .不分:
                return "unisex"
            }
        }
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        genderArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = genderArray[row].rawValue
        label.textAlignment = .center
        return label
        
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        32
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedGender = genderArray[row].getGender()
    }
}
