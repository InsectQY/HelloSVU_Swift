//
//  TodayWeatherView.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/5/23.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

class TodayWeatherView: UIView ,NibLoadable{

    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var condLabel: UILabel!
    @IBOutlet weak var condImage: UIImageView!
    @IBOutlet weak var windScLabel: UILabel!
    @IBOutlet weak var windDirLabel: UILabel!
    @IBOutlet weak var humLabel: UILabel!
    
    @IBOutlet weak var dressAdviceLabel: UILabel!
    @IBOutlet weak var uvLabel: UILabel!
    @IBOutlet weak var travelLabel: UILabel!
    @IBOutlet weak var dressLabel: UILabel!
    @IBOutlet weak var washLabel: UILabel!
    @IBOutlet weak var sportLabel: UILabel!
    @IBOutlet weak var comfortLabel: UILabel!
    
    var weatherData: WeatherData? {
        
        didSet {
            
            tempMaxLabel.text = weatherData?.daily_forecast?.first?.tmp?.max
            tempMinLabel.text = weatherData?.daily_forecast?.first?.tmp?.min
            tempLabel.text = weatherData?.now?.tmp
            condImage.image = UIImage(named: weatherData?.now?.cond?.code ?? "")
            condLabel.text = weatherData?.now?.cond?.txt
            windDirLabel.text = weatherData?.now?.wind?.dir
            windScLabel.text = weatherData?.now?.wind?.sc
            
            humLabel.text = weatherData?.now?.hum
            
            dressAdviceLabel.text = weatherData?.suggestion?.drsg?.txt
            uvLabel.text = weatherData?.suggestion?.uv?.brf
            travelLabel.text = weatherData?.suggestion?.trav?.brf
            dressLabel.text = weatherData?.suggestion?.drsg?.brf
            washLabel.text = weatherData?.suggestion?.cw?.brf
            sportLabel.text = weatherData?.suggestion?.sport?.brf
            comfortLabel.text = weatherData?.suggestion?.comf?.brf
        }
    }
}
