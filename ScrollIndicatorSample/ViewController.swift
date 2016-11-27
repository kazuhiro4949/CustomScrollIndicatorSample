//
//  ViewController.swift
//  ScrollIndicatorSample
//
//  Created by Kazuhiro Hayashi on 11/27/16.
//  Copyright © 2016 Kazuhiro Hayashi. All rights reserved.
//

import UIKit

class ScrollIndicateController: NSObject {
     weak private var scrollView: UIScrollView?
    
    override init() {
        super.init()
    }
    
    func indicate(on scrollView: UIScrollView) {
        self.scrollView = scrollView
        backgroundView.frame.size = CGSize(width: 0, height: scrollView.frame.height)
        backgroundView.frame.origin = CGPoint(x: scrollView.bounds.maxX, y: scrollView.bounds.minY)

        scrollView.addSubview(backgroundView)
        scrollView.addSubview(contentView)
    }
    
    var keepIndicating: Bool = true
    
    var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 1.5
        return view
    }()
    
    var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 1.5
        return view
    }()
    
    func update() {
        guard let scrollView = scrollView else {
            return
        }
        
        contentView.frame.origin.y = scrollView.contentOffset.y / scrollView.contentSize.height
        contentView.frame.size.height = scrollView.bounds.size.height / scrollView.contentSize.height
    }
    
}


class ScrollIndicator: UIView {
    enum Position {
        case leading
        case trailing
    }
    
    weak private var scrollView: UIScrollView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 1.5
        layer.masksToBounds = true
        backgroundColor = UIColor.black.withAlphaComponent(0.2)
        contentView.frame = bounds
        contentView.layer.cornerRadius = 1.5
        contentView.layer.masksToBounds = true
        addSubview(contentView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 1.5
        layer.masksToBounds = true
        backgroundColor = UIColor.black.withAlphaComponent(0.2)
        contentView.frame = bounds
        contentView.layer.cornerRadius = 1.5
        contentView.layer.masksToBounds = true
        addSubview(contentView)
    }
    
    var keepIndicating: Bool = true
    
    var contentView: UIView = {
        let view = UIView()
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return view
    }()
    
    func update(on scrollView: UIScrollView) {
        contentView.frame.size.height = bounds.size.height * (scrollView.bounds.size.height / scrollView.contentSize.height)

        frame.origin.y = scrollView.contentOffset.y
        let updateOffsetY = bounds.size.height * (scrollView.contentOffset.y / scrollView.contentSize.height)
        let correctedOffsetY = min(bounds.size.height - 6, max(updateOffsetY, -contentView.frame.height + 6))
        contentView.frame.origin.y = correctedOffsetY
    }
}


class ViewController: UIViewController , UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    let indicator = ScrollIndicator()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicator.frame = CGRect(x: scrollView.bounds.maxX - 6, y: 3, width: 3, height: scrollView.frame.height - 6)
        indicator.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin, .flexibleTopMargin, .flexibleBottomMargin]
        scrollView.addSubview(indicator)
        scrollView.delegate = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        UIView.animate(withDuration: 0.2, animations: { [weak self] in self?.indicator.alpha = 1 })
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        indicator.update(on: scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        UIView.animate(withDuration: 0.2, animations: { [weak self] in self?.indicator.alpha = 0.5 })
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard !decelerate else {
            return
        }
        
//        UIView.animate(withDuration: 0.2, animations: { [weak self] in self?.indicator.alpha = 0.5 })
    }
}

