//
//  ForecastCell.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/5/23.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {

    @IBOutlet weak var condLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureMin: UILabel!
    @IBOutlet weak var temperatureMax: UILabel!
    
    var forecast : DailyForecast? {
        
        didSet {
            
            if let date = Date(fromString: forecast?.date ?? "", format: "yyyy-MM-dd") {
                
                if date.isToday {
                    dateLabel.text = date.weekday + "(今天)"
                }else if date.isYesterday {
                    dateLabel.text = date.weekday + "(昨天)"
                }else if date.isTomorrow {
                    dateLabel.text = date.weekday + "(明天)"
                }else {
                    dateLabel.text = "\(date.weekday)(\(date.toString(format: "MM/dd")))"
                }
            }
            weatherImage.image = UIImage(named: forecast?.cond?.code_d ?? "")
            condLabel.text = forecast?.cond?.txt_d
            temperatureMin.text = "\(forecast?.tmp?.min ?? "")℃"
            temperatureMax.text = "\(forecast?.tmp?.max ?? "")℃"
        }
    }
    
}
