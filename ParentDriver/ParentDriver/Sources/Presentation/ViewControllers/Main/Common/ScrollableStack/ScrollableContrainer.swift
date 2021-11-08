//
//  ScrollableContrainer.swift
//  HapDay
//
//  Created by Pavel Reva on 21.09.2021.
//  Copyright © 2021 Valtech. All rights reserved.
//

import UIKit

protocol ScrollableContrainer {
    var scrollView: UIScrollView { get }
    var scrollableContainer: UIView { get }
}

extension ScrollableContrainer where Self: UIViewController {
    func configureScrollView() {
        scrollView.isScrollEnabled = true
    }
    
    func configureScrollConstraints() {        
        scrollView.addSubview(scrollableContainer)
        scrollableContainer.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
            make.centerX.equalTo(scrollView.snp.centerX)
            make.centerY.equalTo(scrollView.snp.centerY).priority(.low)
        }
    }
}
