//
//  BirthdayTableViewCell.swift
//  STYLiSH
//
//  Created by cleopatra on 2023/6/3.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import Foundation
import UIKit



class BirthdayTableViewCell: UITableViewCell{
    
    
    let birthdayLabel: UILabel = {
        let birthdayLabel = UILabel()
        birthdayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return birthdayLabel
    }()
//    let birthdayButton: UIButton = {
//        let birthdayButton = UIButton()
//        birthdayButton.translatesAutoresizingMaskIntoConstraints = false
//
//        return birthdayButton
//    }()
    let birthdayTextField: UITextField = {
        let birthdayTextField = UITextField()
        birthdayTextField.translatesAutoresizingMaskIntoConstraints = false
        //??
        birthdayTextField.borderStyle = .roundedRect
        birthdayTextField.placeholder = "選擇日期"
        birthdayTextField.textAlignment = .center
        
        return birthdayTextField
    }()
    let birthdayPicker: UIDatePicker = {
        let birthdayPicker = UIDatePicker()
        if #available(iOS 13.4, *) {
            birthdayPicker.preferredDatePickerStyle = .wheels
        }
        birthdayPicker.datePickerMode = .date
        birthdayPicker.locale = Locale(identifier: "zh_Hans_CN")
        birthdayPicker.addTarget(self, action: #selector(birthdayPickerValueChanged), for: .valueChanged)
        
        return birthdayPicker
    }()
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy 年 MM 月 dd 日"
        
        return formatter
    }()
    let selectedFormatter: DateFormatter = {
        let selectedFormatter = DateFormatter()
        selectedFormatter.dateFormat = "yyyy-MM-dd"
        
        return selectedFormatter
    }()
    let constellationLabel: UILabel = {
        let constellationLabel = UILabel()
        constellationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return constellationLabel
    }()
    var selectedDateString: String?
    var selectedConstellation: String?
    
    func layoutCell(){
        
        [birthdayLabel, birthdayTextField, constellationLabel].forEach { subview in
            self.contentView.addSubview(subview)
        }
        
        self.contentView.bringSubviewToFront(birthdayPicker)
        birthdayTextField.inputView = birthdayPicker
        
        NSLayoutConstraint.activate([
            birthdayLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12),
            birthdayLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24),
            birthdayTextField.topAnchor.constraint(equalTo: birthdayLabel.bottomAnchor, constant: 8),
            birthdayTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            birthdayTextField.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -24),
            birthdayTextField.heightAnchor.constraint(equalToConstant: 32),
            constellationLabel.topAnchor.constraint(equalTo: birthdayTextField.bottomAnchor, constant: 8),
            constellationLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            constellationLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12)
        ])
        
    }
    
    
    @objc func birthdayPickerValueChanged(_ sender: UIDatePicker) {
            let selectedDate = sender.date
            let formattedDate = formatter.string(from: selectedDate)
            birthdayTextField.text = formattedDate
            
            let selectedFormattedDate = selectedFormatter.string(from: selectedDate)
            selectedDateString = selectedFormattedDate
            print("輸入日期為 \(selectedDateString)")

            let monthComponentOfDate = selectedDate.get(.month)
            let dayComponentOfDate = selectedDate.get(.day)
            
        enum constellation: String{
            case 水瓶座
            case 雙魚座
            case 牡羊座
            case 金牛座
            case 雙子座
            case 巨蟹座
            case 獅子座
            case 處女座
            case 天秤座
            case 天蠍座
            case 射手座
            case 摩羯座
            
            func getZodiac() -> String{
                switch self{
                case .水瓶座:
                    return "Aquarius"
                case .雙魚座:
                    return "Pisces"
                case .牡羊座:
                    return "Aries"
                case .金牛座:
                    return "Taurus"
                case .雙子座:
                    return "Gemini"
                case .巨蟹座:
                    return "Cancer"
                case .獅子座:
                    return "Leo"
                case .處女座:
                    return "Virgo"
                case .天秤座:
                    return "Libra"
                case .天蠍座:
                    return "Scorpio"
                case .射手座:
                    return "Sagittarius"
                case .摩羯座:
                    return "Capricorn"
                }
            }
            
        }
        
        
        var zodiac: constellation = { if ((monthComponentOfDate == 1 && dayComponentOfDate >= 20) || (monthComponentOfDate == 2 && dayComponentOfDate <= 18)) {
            return constellation.水瓶座
            
        } else if ((monthComponentOfDate == 2 && dayComponentOfDate >= 19) || (monthComponentOfDate == 3 && dayComponentOfDate <= 20)) {
            return constellation.雙魚座
            
        } else if ((monthComponentOfDate == 3 && dayComponentOfDate >= 21) || (monthComponentOfDate == 4 && dayComponentOfDate <= 19)) {
            return constellation.牡羊座
            
        } else if ((monthComponentOfDate == 4 && dayComponentOfDate >= 20) || (monthComponentOfDate == 5 && dayComponentOfDate <= 20)) {
            return constellation.金牛座
            
        } else if ((monthComponentOfDate == 5 && dayComponentOfDate >= 21) || (monthComponentOfDate == 6 && dayComponentOfDate <= 21)) {
            return constellation.雙子座
            
        } else if ((monthComponentOfDate == 6 && dayComponentOfDate >= 22) || (monthComponentOfDate == 7 && dayComponentOfDate <= 22)) {
            return constellation.巨蟹座
            
        } else if ((monthComponentOfDate == 7 && dayComponentOfDate >= 23) || (monthComponentOfDate == 8 && dayComponentOfDate <= 22)) {
            return constellation.獅子座
            
        } else if ((monthComponentOfDate == 8 && dayComponentOfDate >= 23) || (monthComponentOfDate == 9 && dayComponentOfDate <= 22)) {
            return constellation.處女座
            
        } else if ((monthComponentOfDate == 9 && dayComponentOfDate >= 23) || (monthComponentOfDate == 10 && dayComponentOfDate <= 22)) {
            return constellation.天秤座
            
        } else if ((monthComponentOfDate == 10 && dayComponentOfDate >= 23) || (monthComponentOfDate == 11 && dayComponentOfDate <= 21)) {
            return constellation.天蠍座
            
        } else if ((monthComponentOfDate == 11 && dayComponentOfDate >= 22) || (monthComponentOfDate == 12 && dayComponentOfDate <= 21)) {
            return constellation.射手座
            
        } else {
            return constellation.摩羯座
            
        }
        }()
        constellationLabel.text = zodiac.rawValue
        selectedConstellation = zodiac.getZodiac()
    }
    
}


//讓 Date() 可以取到個別月份、日
extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
