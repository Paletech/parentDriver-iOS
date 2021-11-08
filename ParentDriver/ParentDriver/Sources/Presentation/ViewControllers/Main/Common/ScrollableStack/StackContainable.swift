//
//  ScrollableStackContainable.swift
//  HapDay
//
//  Created by Pavel Reva on 08.09.2021.
//  Copyright © 2021 Valtech. All rights reserved.
//

import UIKit

protocol StackContainable: AnyObject {
    var stackView: UIStackView { get set }
    func dataSourcesDidUpdate(dataSource: DataSourceComposable)
    func insert(view: UIView, atIndex: Int)
    func remove(atIndex: Int) 
}

extension StackContainable where Self: UIViewController {
    func dataSourcesDidUpdate(dataSource: DataSourceComposable) {
        dataSource.views.forEach {
            stackView.addArrangedSubview($0)
        }
    }

    func configureStackView() {
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.alignment = .fill
    }
    
    func insert(view: UIView, atIndex: Int) {
        stackView.insertArrangedSubview(view, at: atIndex)
    }
    
    func remove(atIndex: Int) {
       stackView.arrangedSubviews[safe: atIndex]?.removeFromSuperview()
    }
}

extension StackContainable where Self: UIViewController & ScrollableContrainer {
    func configureScrollStackViewContstraints(horizontalOffset: CGFloat) {
        scrollableContainer.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.centerX.equalTo(scrollableContainer.snp.centerX)
            make.left.equalTo(horizontalOffset)
            make.top.equalTo(scrollableContainer.snp.top)
        }
    }
}
