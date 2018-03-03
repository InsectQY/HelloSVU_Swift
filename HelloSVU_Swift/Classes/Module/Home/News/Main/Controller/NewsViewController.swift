//
//  NewsViewController.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/5/23.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

private let NewsAllChannels = "newsAllChannels"
private let NewsCurrentChannels = "newsCurrentChannels"

class NewsViewController: BaseViewController {

    private lazy var channelsID: [String: String] = {
        
        if let path = Bundle.main.path(forResource: "News.plist", ofType: nil), let news = NSDictionary(contentsOfFile: path) as? [String: String] {
            return news
        }
        return ["头条": "SYLB10,SYDT10"]
    }()
    
    // MARK: - 所有频道
    private lazy var allChannels: [String] = {
        
        var channels = [String]()
        for (key, value) in channelsID {
            channels.append(key)
        }
        return channels
    }()
    
    // MARK: - 当前选择频道
    private lazy var currentChannels: [String] = {
 
        if let currentChannels = UserDefaults.standard.array(forKey: NewsCurrentChannels) {
            return currentChannels as! [String]
        }
        return ["头条","娱乐","军事","体育","游戏","暖新闻","社会","数码","NBA"]
    }()
    
    private lazy var JhtCurrentChannels: [JhtNewsChannelItemModel] = {
        
        var tmpCurrentChannels = [JhtNewsChannelItemModel]()
        for channel in currentChannels {

            let model = JhtNewsChannelItemModel()
            model.titleName = channel
            tmpCurrentChannels.append(model)
        }
        return tmpCurrentChannels
    }()
    
    // MARK: - 选择剩下的频道
    private lazy var remainChannels: [String] = {
        
        var channels = [String]()
        channels += allChannels
        for channel in currentChannels {
            channels.removeAll(channel)
        }
        return channels
    }()
    
    // MARK: - 待添加的频道
    private lazy var JhtToAddChannels: [JhtNewsChannelItemModel] = {
        
        var tmpCurrentChannels = [JhtNewsChannelItemModel]()
        for channel in remainChannels {
            
            let model = JhtNewsChannelItemModel()
            model.titleName = channel
            tmpCurrentChannels.append(model)
        }
        return tmpCurrentChannels
    }()
    
    // MARK: - LazyLoad
    private lazy var itemEditModel: JhtNewsChannelItemEditParamModel = {
        
        let itemEditModel = JhtNewsChannelItemEditParamModel()
        // 是否存在删除（排序删除，或者只有排序没有删除）
        itemEditModel.isExistDelete = true
        return itemEditModel
    }()
    
    // MARK: - JhtChannelBarAndSlideViewConnect_参数mode
    private lazy var barAndSlideModel: JhtChannelBarAndSlideViewConnectParamModel = {
        
        let barAndSlideModel = JhtChannelBarAndSlideViewConnectParamModel()
        
        // 用于切换频道栏 尾部加号按钮 设置的参数model
        let channelTailBtnModel = JhtChannelBarTailBtnModel()
        // 是否添加频道栏尾部的加号Btn
        channelTailBtnModel.isAddTailBtn = true
        barAndSlideModel.channelTailBtnModel = channelTailBtnModel
        
        // 颜色字号
        let channelColorAndFontModel = JhtChannelBarColorAndFontModel()
        channelColorAndFontModel.itemNormalColor = .darkGray
        channelColorAndFontModel.itemSelectedColor = .red
        channelColorAndFontModel.itemNormalFont = PFR16Font
        channelColorAndFontModel.itemSelectedFont = PFR18Font
        channelColorAndFontModel.trackColor = .red
        barAndSlideModel.channelColorAndFontModel = channelColorAndFontModel
        
        // 装有ChannelModel 待添加的数组
        var array: NSMutableArray = NSMutableArray.init(array: JhtToAddChannels)
        barAndSlideModel.toAddItemArray = array
        // 不能移动删除频道的名字数组
        var notMoveNameArray: NSMutableArray = ["头条"]
        barAndSlideModel.notMoveNameArray = notMoveNameArray
        // 选中的索引值
        barAndSlideModel.selectedIndex = 0
        
        return barAndSlideModel
    }()
    
    private lazy var slideView: JhtChannelBarAndSlideViewConnect = {
        
        var array: NSMutableArray = NSMutableArray.init(array: JhtCurrentChannels)
        let slideView = JhtChannelBarAndSlideViewConnect(slideViewAndItemEditViewWithBarAndSlideModel: barAndSlideModel, withNewsChannelItemEdit: itemEditModel, withIsExistNavOrTab: NT_IsExist.onlyHave_N, withChanelArray: array, withBaseViewController: self, withDelegte: self)
        if let slideView = slideView {
            slideView.backgroundColor = .white
            return slideView
        }
        return slideView!
    }()
    
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isTranslucent = true
    }
}

// MARK: - 设置 UI 界面
extension NewsViewController {
    
    private func setUpUI() {
        
        view.addSubview(slideView)
    }
    
    // MARK: - 数据持久化抽取
    private func updateCurrentChannels(content: [String],key: String) {
    
        UserDefaults.standard.set(content, forKey: key)
        UserDefaults.standard.synchronize()
    }
}

// MARK: - JhtTotalSlideViewDelegate
extension NewsViewController: JhtTotalSlideViewDelegate{
    
    func numberOfTabs(in sender: JhtTotalSlideView!) -> Int {
        return JhtCurrentChannels.count
    }
    
    func jhtTotalSlideView(_ sender: JhtTotalSlideView!, controllerAt index: Int) -> UIViewController! {
        
        let model = JhtCurrentChannels[index]
        let name = model.titleName ?? ""
        let vc = NewsPartsViewController()
        vc.titleName = name
        vc.channelID = channelsID[name] ?? ""
        return vc
    }
    
    func jhtTotalSlideView(_ sender: JhtTotalSlideView!, didSelectedAt index: Int) {
        
//        let model = JhtCurrentChannels[index]
//        let cache = slideView.cache as AnyObject
//        let vc = cache.object(forKey: "\(index)") as AnyObject
//        if vc.isKind(of: NewsPartsViewController.self) {
//            
//            let partsVc: NewsPartsViewController = vc as! NewsPartsViewController
//            let name = model.titleName ?? ""
//            partsVc.channelID = channelsID[name] ?? ""
//        }
    }
    
    func jhtTotalSlideView(withSortModelArr modelArr: [Any]!, withNameArray nameArray: [Any]!, withSelect selectedIndex: Int) {
        
        JhtCurrentChannels.removeAll()
        JhtCurrentChannels += modelArr as! [JhtNewsChannelItemModel]
        updateCurrentChannels(content: nameArray as! [String], key: NewsCurrentChannels)
    }
}
