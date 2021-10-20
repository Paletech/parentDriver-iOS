//
//  OvertouchButtom.swift
//  ParentView
//
//  Created by Pavlo Reva on 06/06/2020.
//  Copyright © 2020 Paletech. All rights reserved.
//

import UIKit

final class OverTouchButton: UIButton {

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let newArea = CGRect(x: bounds.minX - 10, y: bounds.minX - 10, width: bounds.width + 20, height: bounds.height + 20)
        return newArea.contains(point)
    }

}
