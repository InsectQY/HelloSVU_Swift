//
//  QYCycleView.swift
//  DouYuLive
//
//  Created by Insect on 2017/4/10.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

private let cycleID = "cycleID"

class QYCycleView: UIView {

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var flowLayout: UICollectionViewFlowLayout!
    
    var cycleTimer: Timer?
    var cycleData: [String]? {
        
        didSet {
            
            pageControl.numberOfPages = cycleData?.count ?? 0
            collectionView.reloadData()
            let indexPath = IndexPath(item: (cycleData?.count ?? 0) * 100, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            removeCycleTimer()
            addCycleTimer()
        }
    }
    
    // MARK: - 界面初始化
    override func awakeFromNib() {
        
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "QYCycleCell", bundle: nil), forCellWithReuseIdentifier: cycleID)
        flowLayout.itemSize = CGSize(width: ScreenW, height: ScreenH * 0.3)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
    }
}

// MARK: - 类方法加载 xib
extension QYCycleView {

     class func viewFromXib() ->  QYCycleView {
        
        return Bundle.main.loadNibNamed("QYCycleView", owner: nil, options: nil)?.last as! QYCycleView
    }
}

// MARK: - UICollectionViewDataSource
extension QYCycleView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleData?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cycleID, for: indexPath) as! QYCycleCell
        cell.cycleData = cycleData?[indexPath.row % (cycleData?.count ?? 1)]
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension QYCycleView: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleData?.count ?? 1)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}

// MARK: - 定时器方法
extension QYCycleView {
    
    private func addCycleTimer() {
        cycleTimer = Timer(timeInterval: 5.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: RunLoopMode.commonModes)
    }
    
    private func removeCycleTimer() {
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
    @objc private func scrollToNext() {
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}
