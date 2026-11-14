//
//  Badge.swift
//  GratefulMoments
//
//  Created by Jagruti Parab on 14/11/26.
//

import Foundation
import SwiftData


@Model
class Badge {
    var details: BadgeDetails
    
    
    init(details: BadgeDetails) {
        self.details = details
    }
    
}


extension Badge {
    static var sample: Badge {
        let badge = Badge(details: .firstEntry)
        return badge
    }
}
