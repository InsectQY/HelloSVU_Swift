//
//  AllBusLineViewController.swift
//  HelloSVU_Swift
//
//  Created by a on 2017/11/23.
//Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

private let AllBusLineCellID = "AllBusLineCellID"

class AllBusLineViewController: UIViewController {
    
    /// 更换其他公交线路
    var changeBusLine: ((_ selLineIndex: Int) -> ())?
    
    /// 公交路径规划方案
    var segment: AMapSegment?
    /// 当前选择的公交线路
    var selBusLineIndex = 0
    
    private var lastCell: AllBusLineCell?
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - LazyLoad
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
}

// MARK: - 设置 UI 界面
extension AllBusLineViewController {
    
    private func setUpUI() {
        
        setUpTableView()
    }
    
    private func setUpTableView() {
        
        tableView.register(UINib(nibName: "AllBusLineCell", bundle: nil), forCellReuseIdentifier: AllBusLineCellID)
        tableView.rowHeight = 60
        tableView.reloadData()
        tableView(tableView, didSelectRowAt: IndexPath(row: selBusLineIndex, section: 0))
    }
    
    // MARK: - 取消按钮点击事件
    @IBAction func cancelBtnDidClick(_ sender: Any) {
        SVUAnimation.dismiss(animateDuration: 0.2, completion: nil)
    }
}

// MARK: - UITableViewDataSource
extension AllBusLineViewController: UITableViewDataSource {
    
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
extension AllBusLineViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        lastCell?.selImage.isHidden = true
        let cell = tableView.cellForRow(at: indexPath) as! AllBusLineCell
        cell.selImage.isHidden = false
        lastCell = cell
        SVUAnimation.dismiss(animateDuration: 0.2, completion: nil)
        changeBusLine?(indexPath.row)
    }
}
