//
//  SVUWeatherViewController.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/5/10.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

import CoreLocation

fileprivate let ForecastCellID = "ForecastCellID"

fileprivate let WeatherCellH : CGFloat = 44
fileprivate let WeatherNaviColor : UIColor = UIColor(r: 24, g: 51, b: 91)

class WeatherViewController: UIViewController {
    
    // MARK: - LazyLoad
    fileprivate lazy var locations : CLLocation = CLLocation()
    fileprivate lazy var weatherData : WeatherData = WeatherData()
    // MARK: - tableView
    fileprivate lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: UIScreen.main.bounds)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "ForecastCell", bundle: nil), forCellReuseIdentifier: ForecastCellID)
        tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.rowHeight = WeatherCellH
        self.view.addSubview(tableView)
        return tableView
    }()
    
    // MARK: - tableView-Header
    fileprivate lazy var todayWeatherView: TodayWeatherView = {
        
        let todayWeatherView = TodayWeatherView.loadFromNib()
        todayWeatherView.h = 610 - 64 + ScreenH - 245
        return todayWeatherView
    }()
    
    // MARK: - 背景图片
    fileprivate lazy var bgView: UIImageView = {
        
        let bgView = UIImageView(x: 0, y: 0, w: ScreenW, h: ScreenH, imageName: "bg_city")
        return bgView
    }()
    
    // MARK: - 动态模糊
    fileprivate lazy var effectView: UIVisualEffectView = {
        
        let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        effectView.frame = UIScreen.main.bounds
        return effectView
    }()
    
    // MARK: - 位置管理者
    fileprivate lazy var locationM: CLLocationManager = {
        
        let locationM = CLLocationManager()
        locationM.delegate = self
        locationM.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        return locationM
    }()
    
    // MARK: - 反地理编码
    fileprivate lazy var gecoder: CLGeocoder = CLGeocoder()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        locationM.startUpdatingLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        navigationController?.navigationBar.QYBackgroundColor(backgroundColor: WeatherNaviColor)
        navigationController?.navigationBar.QYElementsAlpha(alpha: 0)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.navigationBar.QYReset()
    }
}

// MARK: - CLLocationManagerDelegate
extension WeatherViewController : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        self.locations = locations.last!
    }
}

// MARK: - 设置 UI 界面
extension WeatherViewController {
    
    fileprivate func setUpUI() {
        
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = .white
        view.addSubview(bgView)
        bgView.addSubview(effectView)
        setUpRefresh()
    }
    
    // MARK: - 设置头部视图
    fileprivate func setUpTableHeaderView() {
        
        tableView.tableHeaderView = todayWeatherView
        todayWeatherView.weatherData = weatherData
    }
}

// MARK: - 设置刷新
extension WeatherViewController {
    
    fileprivate func setUpRefresh() {
        
        tableView.mj_header = SVURefreshHeader.init(refreshingTarget: self, refreshingAction: #selector(self.loadAllNewData))
        tableView.mj_header.beginRefreshing()
    }
}

// MARK: - 加载数据
extension WeatherViewController {
    
    // MARK: - 加载所有最新数据
    @objc fileprivate func loadAllNewData() {
        
        loadBackImageData()
        loadWeatherData()
    }
    
    // MARK: - 加载背景图片数据
    @objc fileprivate func loadBackImageData() {
        
    }
    
    // MARK: - 加载天气数据
    @objc fileprivate func loadWeatherData() {
        
       
    }
}

// MARK: - UITableViewDataSource
extension WeatherViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let daily_forecast = weatherData.daily_forecast {
           return daily_forecast.count
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ForecastCellID, for: indexPath) as! ForecastCell
        cell.forecast = weatherData.daily_forecast?[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate
extension WeatherViewController : UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let alpha = scrollView.contentOffset.y / 400
        effectView.alpha = alpha
        scrollView.contentOffset.y > 10 ? navigationController?.navigationBar.QYElementsAlpha(alpha: alpha) : navigationController?.navigationBar.QYElementsAlpha(alpha: 0)
    }
}

