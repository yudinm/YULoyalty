//
//  ViewController.swift
//  YULoyalty
//
//  Created by Michael Yudin on 05.12.2017.
//  Copyright © 2017 Michael Yudin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let reviewManager = ReviewManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        YULoyalty.instance.configure(currentLoyalty: 1, currentLevel: .starter)
        YULoyalty.instance.levelAchievedBlock = { level in
            print("Level Achived: \(level)")
            self.reviewManager.complitionBlock = { answer in
                switch answer {
                case .yes:
                    self.reviewManager.askForReview(parentVC: self)
                case .no:
                    YULoyalty.instance.incrementLoyalty(weight: .dontLikeApp)
                case .cancel:
                    YULoyalty.instance.incrementLoyalty(weight: .askLater)
                }
            }
            
        }
        YULoyalty.instance.syncCurrentStateBlock = { loyalty, level in
            print("Sync Cyrrent Loyalty: \(loyalty) Level: \(level)")
        }
    }

    @IBAction func buttonDidTapped(_ sender: UIButton) {
        guard let title = sender.titleLabel?.text else { return }
        switch title {
        case "Start App":
            YULoyalty.instance.incrementLoyalty(weight: .startApp)
        case "Bookmark":
            YULoyalty.instance.incrementLoyalty(weight: .bookmarkArticle)
        case "Crash App":
            YULoyalty.instance.incrementLoyalty(weight: .crashedApp)
        default:
            return
        }
    }
    

}

