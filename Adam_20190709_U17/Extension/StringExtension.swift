//
//  StringExtension.swift
//  Adam_20190705_U17
//
//  Created by Adonis_HongYang on 2019/7/5.
//  Copyright © 2019 Adonis_HongYang. All rights reserved.
//

import Foundation

extension String {
    public func substring(from index: Int) -> String {
        if self.count > index {
            let startIndex = self.index(self.startIndex, offsetBy: index)
            let subString = self[startIndex..<self.endIndex]
            return String(subString)
        } else {
            return self
        }
    }
}
