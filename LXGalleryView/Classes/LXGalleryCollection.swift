//
//  LXGalleryCollection.swift
//  LXGalleryView
//
//  Created by Leon Hoppe on 14.06.18.
//

import UIKit

extension CGFloat {
    static let SPACING: CGFloat = 0.0
}

public class LXGalleryCollection: UICollectionView {
    
    //MARK: Enums
    private enum ScrollDirection {
        case forwards
        case backwards
    }
    
    //MARK: Properties
    var galleryView: LXGalleryView!
    fileprivate var itemsCount: Int = 0
    fileprivate var timer: Timer?
    fileprivate var initialScroll = true
    private var scrollDirection: ScrollDirection = .forwards
    
    var isAnimated = true {
        didSet {
            switch self.isAnimated {
            case true:
                self.startTimer()
                
            case false:
                self.stopTimer()
            }
        }
    }
    
    var duration: Double = 3.0
    var isInfinite = true {
        didSet {
            self.reloadData()
        }
    }
    
    var nextPage: Int?
    var lastPage: Int?
    
    //MARK: Init
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.delegate = self
        self.dataSource = self
        
        let flowLayout = self.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.scrollDirection = .horizontal
        
        self.isPagingEnabled = true
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.bounces = false
        
        self.isInfinite = true
        self.isAnimated = true
        
        self.nextPage = self.getCurrentPage() + 1
        self.lastPage = self.getCurrentPage() - 1
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func scroll(toDirection: ScrollDirection, senderIsBtn: Bool) {
        let currentRow = self.getCurrentPage() - 1
        
        switch toDirection {
        case .forwards:
            if(isInfinite) {
                let toIndex = IndexPath(row: (currentRow + 1), section: 0)
                self.startScrolling(toIndex)
            } else {
                if(currentRow < self.itemsCount - 1) {
                    let toIndex = IndexPath(row: (currentRow + 1), section: 0)
                    self.startScrolling(toIndex)
                } else {
                    if(isAnimated && !senderIsBtn) {
                        self.scrollDirection = .backwards
                        self.scroll(toDirection: self.scrollDirection, senderIsBtn: false)
                    } else if(isAnimated && senderIsBtn) {
                        self.startTimer()
                    }
                }
            }
            
        case .backwards:
            if(isInfinite) {
                let toIndex = IndexPath(row: (currentRow - 1), section: 0)
                self.startScrolling(toIndex)
            } else {
                if(currentRow > 0) {
                    let toIndex = IndexPath(row: (currentRow - 1), section: 0)
                    self.startScrolling(toIndex)
                } else {
                    if(isAnimated && !senderIsBtn) {
                        self.scrollDirection = .forwards
                        self.scroll(toDirection: self.scrollDirection, senderIsBtn: false)
                    } else if(isAnimated && senderIsBtn) {
                        self.startTimer()
                    }
                }
            }
        }
    }
    
    private func startScrolling(_ to: IndexPath) {
        // Disable interaction during scrolling
        self.galleryView.rightButton.isUserInteractionEnabled = false
        self.galleryView.leftButton.isUserInteractionEnabled = false
        self.isUserInteractionEnabled = false
        
        self.scrollToItem(at: to, at: .centeredHorizontally, animated: true)
        if(isAnimated) {
            self.startTimer()
        }
    }
    
    @objc func press(button: UIButton) {
        self.stopTimer()
        switch button {
        case self.galleryView.rightButton:
            self.scroll(toDirection: .forwards, senderIsBtn: true)
            
        case self.galleryView.leftButton:
            self.scroll(toDirection: .backwards, senderIsBtn: true)
            
        default:
            self.scroll(toDirection: self.scrollDirection, senderIsBtn: false)
        }
    }
    
    fileprivate func startTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: Double(self.duration), target: self, selector: #selector(press(button:)), userInfo: nil, repeats: false)
    }
    
    fileprivate func stopTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
}

//MARK: Extensions
extension LXGalleryCollection: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // UICollectionViewDataSource
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let dataSource = self.galleryView.dataSource else {
            return 0
        }
        
        let numberOfItems = dataSource.galleryView(self.galleryView, numberOfItemsInSection: 0)
        
        if numberOfItems == 0 {
            return 0
        }
        
        if(isInfinite) {
            self.itemsCount = numberOfItems
            
            // Need additional 2 items for copied cells at the begin and the end
            return numberOfItems + 2
        } else {
            self.itemsCount = numberOfItems
            return numberOfItems
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let dataSource = self.galleryView.dataSource else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "default", for: indexPath)
        }
        
        if(isInfinite) {
            if(indexPath.row <= 0) {
                // Add last Item to first index
                let lastIndex = IndexPath(row: (self.itemsCount - 1) , section: 0)
                return dataSource.galleryView(self.galleryView, cellForItemAt: lastIndex)
            } else if(indexPath.row >= (self.itemsCount + 1)) {
                // Add first Item to last index
                let firstIndex = IndexPath(row: 0, section: 0)
                return dataSource.galleryView(self.galleryView, cellForItemAt: firstIndex)
            } else {
                let index = IndexPath(row: (indexPath.row - 1), section: 0)
                return dataSource.galleryView(self.galleryView, cellForItemAt: index)
            }
        } else {
            return dataSource.galleryView(self.galleryView, cellForItemAt: indexPath)
        }
    }
    
    // UICollectionViewDelegateFlowLayout
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .SPACING
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .SPACING
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if(self.initialScroll) {
            if(isInfinite) {
                let index = IndexPath(row: 1, section: 0)
                self.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            }
            self.initialScroll = false
            if(isAnimated) {
                startTimer()
            }
        }
        
    }
    
    // UIScrollViewDelegate
    fileprivate func getCurrentPage() -> Int {
        let page = Int(self.contentOffset.x + (self.bounds.width/2)) / Int(self.bounds.width) + 1
        //print(page)
        return page
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.galleryView.delegate?.galleryViewDidScroll?(self.galleryView)
        
        // Call delegate if scroll more than the half of one cell
        let currentPage = getCurrentPage()
        if(currentPage == self.nextPage!) {
            self.nextPage! += 1
            self.lastPage! += 1
            //self.galleryView.delegate?.galleryViewDidPaged!(self.galleryView, toPage: self.toPaged())
            self.galleryView.delegate?.galleryViewDidPaged?(self.galleryView, toPage: self.toPaged())
        } else if(currentPage == self.lastPage) {
            self.lastPage! -= 1
            self.nextPage! -= 1
            self.galleryView.delegate?.galleryViewDidPaged?(self.galleryView, toPage: self.toPaged())
        }
        
        if(isInfinite) {
            if(self.contentOffset.x >= (CGFloat(itemsCount + 1) * self.bounds.width) ) {
                // If current item the last one
                self.scrollToItem(at: IndexPath(row: 1, section: 0), at: .centeredHorizontally, animated: false)
                self.nextPage! = 3
                self.lastPage! = 1
            } else if(self.contentOffset.x <= 0) {
                // If current item the first one
                self.scrollToItem(at: IndexPath(row: itemsCount, section: 0), at: .centeredHorizontally, animated: false)
                self.nextPage! = itemsCount + 2
                self.lastPage! = self.itemsCount
            }
        }
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.stopTimer()
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if(isAnimated) {
            if(!isInfinite) {
                if(self.getCurrentPage() >= self.itemsCount) {
                    // If current item the last one
                    self.startTimer()
                } else if(self.getCurrentPage() <= 1) {
                    // If current item the first one
                    self.startTimer()
                }
            }
        }
    }
    
    public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        self.isUserInteractionEnabled = false
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if(isAnimated) {
            self.startTimer()
        }
        self.isUserInteractionEnabled = true
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.galleryView.rightButton.isUserInteractionEnabled = true
        self.galleryView.leftButton.isUserInteractionEnabled = true
        self.isUserInteractionEnabled = true
    }
    
    private func toPaged() -> Int {
        if(isInfinite) {
            if(self.contentOffset.x >= (CGFloat(itemsCount + 1) * bounds.width - bounds.width/2) ) {
                // If current item the last one
                return 1
            } else if(self.contentOffset.x <= bounds.width/2) {
                // If current item the first one
                return self.itemsCount
            } else {
                return self.getCurrentPage() - 1
            }
        } else {
            return self.getCurrentPage()
        }
    }
}

