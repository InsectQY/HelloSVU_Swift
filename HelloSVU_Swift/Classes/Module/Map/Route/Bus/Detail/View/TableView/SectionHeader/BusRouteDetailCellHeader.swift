//
//  BusRouteDetailCellHeader.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/10/16.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit
import EZSwiftExtensions

private let BusLineCellID = "BusLineCellID"

class BusRouteDetailCellHeader: UITableViewHeaderFooterView,NibReusable {

    /// 途径站点按钮点击回调
    var viaBtnClick: (() -> ())?
    /// 其他公交路线点击回调
    var otherBusLineClick: (() -> ())?
    
    @IBOutlet private weak var routeTypeImage: UIImageView!
    @IBOutlet private weak var busLineLabel: UILabel!
    @IBOutlet private weak var departureStopLabel: UILabel!
    @IBOutlet private weak var viaBusStopsBtn: UIButton!
    @IBOutlet private weak var enterNameBtn: UIButton!
    @IBOutlet private weak var startTimeLabel: UILabel!
    @IBOutlet private weak var endTimeLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet private weak var timeContentView: UIView!
    @IBOutlet private weak var otherBusLineView: UIView!
    
    lazy var busLines: [AMapBusLine] = {
        
        var busLines = [AMapBusLine]()
        
        if let allLine = segment?.buslines {
            
            for line in allLine {
                
                let name = line.name as NSString
                if name.contains("(") { // 去除括号里的内容
                    line.name = name.substring(to: name.range(of: "(").location)
                }
                busLines.append(line)
            }
            busLines.remove(at: info?.busLineIndex ?? 0)
        }
        return busLines
    }()
    
    /// 包含是否展开，是否有多条 busline 以及选择的是第几组的信息
    var info: BusSegment?
    
    var segment: AMapSegment? {
        
        didSet {
            
            if let isOpen = info?.isOpen {
                
                viaBusStopsBtn.isSelected = isOpen
                timeContentView.isHidden = isOpen
            }
            var busLineIndex = 0
            if info?.isSpecified == true {
                busLineIndex = info?.busLineIndex ?? 0
            }
            
            departureStopLabel.text = segment?.buslines[busLineIndex].departureStop.name
            busLineLabel.text = segment?.buslines[busLineIndex].name
            
            // 设置途径站点
            let count = segment?.buslines[busLineIndex].viaBusStops.count ?? 0
            viaBusStopsBtn.isUserInteractionEnabled = count > 0
            if count > 0 {
                viaBusStopsBtn.setTitle("\(String(describing: count))站", for: .normal)
            } else {
                viaBusStopsBtn.setTitle("1站", for: .normal)
            }
            
            // 检查首末班车事件
            if let startTime = segment?.buslines[busLineIndex].startTime {
                
                timeContentView.isHidden = !viaBusStopsBtn.isSelected
                if startTime.length > 2 {
                    
                    let startTime = startTime as NSString
                    let startHour = startTime.substring(to: 2)
                    let startMinute = startTime.substring(from: 2)
                    startTimeLabel.text = "首班   \(startHour):\(startMinute)"
                }
            }
            
            if let endTime = segment?.buslines[busLineIndex].endTime {
                
                timeContentView.isHidden = !viaBusStopsBtn.isSelected
                if endTime.length > 2 {
                    
                    let endTime = endTime as NSString
                    let endHour = endTime.substring(to: 2)
                    let endMinute = endTime.substring(from: 2)
                    endTimeLabel.text = "末班   \(endHour):\(endMinute)"
                }
            }
            
            // 设置交通工具类型图片
            if let type = segment?.buslines[busLineIndex].type {
                let type = type as NSString
                routeTypeImage.image = type.contains("地铁") ? #imageLiteral(resourceName: "subway"): #imageLiteral(resourceName: "bus")
            }
            
            checkEnterAndExitName()
            checkOtherBusLines()
        }
    }
    
    // MARK: - 途径站点点击事件
    @IBAction func viaBtnDidClick(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        viaBtnClick?()
    }
}

extension BusRouteDetailCellHeader {
    
    // MARK: - 检查是否存在进站口和出站口
    private func checkEnterAndExitName() {
        
        enterNameBtn.isHidden = (segment?.enterName.length != nil)
        if segment?.enterName.length != nil {
            enterNameBtn.setTitle("\(String(describing: segment?.enterName))出", for: .normal)
        }
    }
    
    // MARK: - 检查是否存在其他线路
    private func checkOtherBusLines() {
        
        if let count = segment?.buslines.count {
            
            otherBusLineView.isHidden = count <= 1
            if count > 1 {
                setUpCollectionView()
            }
        }
    }
    
    // MARK: - 设置 CollectionView
    private func setUpCollectionView() {
        
        flowLayout.minimumLineSpacing = 3
        collectionView.register(UINib(nibName: "BusLineCell", bundle: nil), forCellWithReuseIdentifier: BusLineCellID)
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension BusRouteDetailCellHeader: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return busLines.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BusLineCellID, for: indexPath) as! BusLineCell
        cell.busLine = busLines[indexPath.item].name
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension BusRouteDetailCellHeader: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = busLines[indexPath.item].name.sizeWithConstrainedWidth(150, PFR12Font)
        return CGSize(width: size.width + 10, height: 15)
    }
}

// MARK: - UICollectionViewDelegate
extension BusRouteDetailCellHeader: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        otherBusLineClick?()
    }
}
