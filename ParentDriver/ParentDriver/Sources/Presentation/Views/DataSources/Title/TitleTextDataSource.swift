//
//  TItleTextDataSource.swift
//  HapDay
//
//  Created by Pavel Reva on 07.09.2021.
//  Copyright © 2021 Valtech. All rights reserved.
//

import Foundation

class TitleTextDataSource: StackDataSource<TitleTextConfig, TitleTextView> {
    override func reload() {
        view.setup(config: item)
    }
}
