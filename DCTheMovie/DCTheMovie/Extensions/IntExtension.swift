//
//  IntExtension.swift
//  DCTheMovie
//
//  Created by Daniel Colnaghi on 26/06/18.
//  Copyright © 2018 Cold Mass Digital Entertainment. All rights reserved.
//

import Foundation

extension Int {
    func toUSCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en-US")
        formatter.numberStyle = .currency
        
        var retValue = ""
        if let formattedTipAmount = formatter.string(from: self as NSNumber) {
            retValue = formattedTipAmount
        }
        
        return retValue
    }
    
    func toRuntime() -> String {
        return "\(self/60)h \((self)%60)m"
    }
}
