//
//  YULoyalty.swift
//  YULoyalty
//
//  Created by Michael Yudin on 05.12.2017.
//  Copyright © 2017 Michael Yudin. All rights reserved.
//

import UIKit

final public class YULoyalty: NSObject {
    
    public typealias LoyaltyPoint = Int
    
    @objc public enum LoyaltyLevels : LoyaltyPoint {
        case starter = 0
        case newbie = 30
        case experienced = 80
        case fanatic = 150
    }
    
    @objc public enum LoyaltyWeights : LoyaltyPoint {
        case startApp = 1
        case bookmarkArticle = 3
        case unbookmarkArticle = 4
        case viewingLive10Minutes = 6
        case crashedApp = -50
        case dontLikeApp = -150
        case askLater = -10
    }
    
    static let instance: YULoyalty = YULoyalty()
    private var currentLoyalty: LoyaltyPoint = 0 {
        
        didSet(oldLoyalty) {
            var levelAchived = LoyaltyLevels.starter
            if currentLoyalty >= LoyaltyLevels.newbie.rawValue && currentLevel.rawValue < LoyaltyLevels.newbie.rawValue {
                levelAchived = LoyaltyLevels.newbie
            } else
            if currentLoyalty >= LoyaltyLevels.experienced.rawValue && currentLevel.rawValue < LoyaltyLevels.experienced.rawValue {
                levelAchived = LoyaltyLevels.experienced
            } else
            if currentLoyalty >= LoyaltyLevels.fanatic.rawValue {
                levelAchived = LoyaltyLevels.fanatic
            }
            if (levelAchived != .starter) { self.currentLevel = levelAchived }
            guard let syncCurrentStateBlock = self.syncCurrentStateBlock else { return }
            syncCurrentStateBlock(currentLoyalty, currentLevel)
        }
    }
    private var currentLevel: LoyaltyLevels = .starter {
        didSet(oldLevel) {
            if currentLevel != oldLevel {
                guard let levelAchievedBlock = self.levelAchievedBlock else { return }
                levelAchievedBlock(currentLevel)
            }
            
        }
    }
    @objc public var levelAchievedBlock: ((_ level:LoyaltyLevels) -> ())?
    @objc public var syncCurrentStateBlock: ((_ loyalty:LoyaltyPoint, _ level:LoyaltyLevels) -> ())?
    
    @objc public func configure(currentLoyalty:LoyaltyPoint, currentLevel:LoyaltyLevels) {
        self.currentLoyalty = currentLoyalty
        self.currentLevel = currentLevel
    }
    
    @objc public func incrementLoyalty(weight:LoyaltyWeights) {
        self.currentLoyalty += weight.rawValue
    }
    
    @objc public func loyaltyPoints() -> LoyaltyPoint {
        return self.currentLoyalty
    }
    
    @objc public func loyaltyLevelText(_ level:LoyaltyLevels) -> String {
        return level.text
    }
    
}

public extension YULoyalty.LoyaltyLevels {
    var text: String {
        switch self {
        case .starter:
            return "starter"
        case .newbie:
            return "newbie"
        case .experienced:
            return "experienced"
        case .fanatic:
            return "fanatic"
        }
    }
}


