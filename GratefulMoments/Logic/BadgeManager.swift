//
//  BadgeManager.swift
//  GratefulMoments
//
//  Created by Jagruti Parab on 14/11/26.
//

import Foundation
import SwiftData


class BadgeManager {
    private let modelContainer: ModelContainer


    init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
    }
    
    
    func loadBadgesIfNeeded() throws {
        let context = modelContainer.mainContext
        var fetchDescriptor = FetchDescriptor<Badge>()
        fetchDescriptor.fetchLimit = 1
        let existingBadges = try context.fetch(fetchDescriptor)
//        if existingBadges.isEmpty {
//            for details in BadgeDetails.allCases {
//                context.insert(Badge(details: details))
//            }
//        }
    }
}

