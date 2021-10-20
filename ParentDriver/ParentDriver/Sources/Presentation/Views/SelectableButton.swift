//
//  SelectableButton.swift
//  MyHappyHabits
//
//  Created by Pavel Reva on 18.06.2021.
//

import UIKit

class SelectableButton: UIButton {
    
    var identifier: String?
    var onSelectionChanged: ((Bool) -> Void)?
    
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
    
    override var isSelected: Bool {
        didSet {
            applySelection()
        }
    }
    
    // MARK: - Init/Deinit
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Private
    
    private func setup() {
        applyNotSelectedStyle()
        addTarget(self, action: #selector(onTouchUpInside), for: .touchUpInside)
    }
    
    private func applySelection() {
        UIView.transition(with: self,
                          duration: 0.4,
                          options: .transitionCrossDissolve,
                          animations: {
                            if self.isSelected {
                                self.applyPrimaryStyle()
                            } else {
                                self.applyNotSelectedStyle()
                            }
                          },
                          completion: nil)
    }
    
    // MARK: - Actions
    
    @objc private func onTouchUpInside() {
        if !self.isSelected {
            feedbackGenerator.impactOccurred()
            self.isSelected.toggle()
        }
        
        onSelectionChanged?(isSelected)
    }
}
