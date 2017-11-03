//
//  BusRouteDetailCellHeader.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/10/16.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

class BusRouteDetailCellHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var busLineLabel: UILabel!
    @IBOutlet weak var departureStopLabel: UILabel!
    @IBOutlet weak var viaBusStopsBtn: UIButton!
    @IBOutlet weak var enterNameBtn: UIButton!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: MaxInteritemSpacingFlowLayout!
    
}
