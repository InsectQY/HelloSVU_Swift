//
//  AllBusLineViewController.swift
//  HelloSVU_Swift
//
//  Created by a on 2017/11/23.
//Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

fileprivate let AllBusLineCellID = "AllBusLineCellID"

class AllBusLineViewController: UIViewController {
    
    /// 公交路径规划方案
    var segment : AMapSegment?
    /// 当前选择的公交线路
    var selBusLineIndex = 0
    
    var lastCell : AllBusLineCell?
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - LazyLoad
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
}

// MARK: - 设置 UI 界面
extension AllBusLineViewController {
    
    fileprivate func setUpUI() {
        
        setUpTableView()
    }
    
    fileprivate func setUpTableView() {
        
        tableView.register(UINib(nibName: "AllBusLineCell", bundle: nil), forCellReuseIdentifier: AllBusLineCellID)
        tableView.rowHeight = 60
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension AllBusLineViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return segment?.buslines.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AllBusLineCellID, for: indexPath) as! AllBusLineCell
        cell.busLine = segment?.buslines[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate
extension AllBusLineViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        lastCell?.selImage.isHidden = true
        let cell = tableView.cellForRow(at: indexPath) as! AllBusLineCell
        cell.selImage.isHidden = false
        lastCell = cell
        SVUAnimation.dismiss(animateDuration: 0.2, completion: nil)
    }
}
