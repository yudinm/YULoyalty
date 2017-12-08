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
    
    @objc public enum Levels : LoyaltyPoint {
        case starter = 0
        case newbie = 30
        case experienced = 80
        case fanatic = 150
    }
    
    @objc public enum Weights : LoyaltyPoint {
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
            var levelAchived = Levels.starter
            if currentLoyalty >= Levels.newbie.rawValue && currentLevel.rawValue < Levels.newbie.rawValue {
                levelAchived = Levels.newbie
            } else
                if currentLoyalty >= Levels.experienced.rawValue && currentLevel.rawValue < Levels.experienced.rawValue {
                    levelAchived = Levels.experienced
                } else
                    if currentLoyalty >= Levels.fanatic.rawValue {
                        levelAchived = Levels.fanatic
            }
            if (levelAchived != .starter) { self.currentLevel = levelAchived }
            guard let syncCurrentStateBlock = self.syncCurrentStateBlock else { return }
            syncCurrentStateBlock(currentLoyalty, currentLevel)
        }
    }
    private var currentLevel: Levels = .starter {
        didSet(oldLevel) {
            if currentLevel != oldLevel {
                guard let levelAchievedBlock = self.levelAchievedBlock else { return }
                levelAchievedBlock(currentLevel)
            }
            
        }
    }
    @objc public var levelAchievedBlock: ((_ level:Levels) -> ())?
    @objc public var syncCurrentStateBlock: ((_ loyalty:LoyaltyPoint, _ level:Levels) -> ())?
    
    @objc public func configure(currentLoyalty:LoyaltyPoint, currentLevel:Levels) {
        self.currentLoyalty = currentLoyalty
        self.currentLevel = currentLevel
    }
    
    @objc public func incrementLoyalty(weight:Weights) {
        self.currentLoyalty += weight.rawValue
    }
    
    @objc public func loyaltyPoints() -> LoyaltyPoint {
        return self.currentLoyalty
    }
    
}

