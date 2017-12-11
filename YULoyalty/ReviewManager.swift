//
//  ReviewManager.swift
//  YULoyalty
//
//  Created by Michael Yudin on 08.12.2017.
//  Copyright © 2017 Michael Yudin. All rights reserved.
//

import UIKit
import StoreKit

@objc final public class ReviewManager: NSObject {
    
    var appID:String
    
    public init(appID:String) {
        self.appID = appID
    }
    
    @objc public enum UserAnswers : Int {
        case yes = 1
        case no = 2
        case cancel = 0
    }
    
    @objc public var complitionBlock: ((_ answer:UserAnswers) -> ())?
    
    @objc public func askForReview(parentVC:UIViewController) {
        let actitle = "Do you like our App?"
        let acmessage = ""
        let ac:UIAlertController = UIAlertController(title: actitle, message: acmessage, preferredStyle: .alert)
        
        let actionYes:UIAlertAction = UIAlertAction(title: UserAnswers.yes.text, style: .default) { action in
            print(UserAnswers.yes.text)
            self.showReviewWindow(appID: self.appID)
            if let complition = self.complitionBlock { complition(UserAnswers.yes) }
        }
        let actionNo:UIAlertAction = UIAlertAction(title: UserAnswers.no.text, style: .default) { action in
            print(UserAnswers.no.text)
            if let complition = self.complitionBlock { complition(UserAnswers.no) }
        }
        let actionCancel:UIAlertAction = UIAlertAction(title: UserAnswers.cancel.text, style: .cancel) { action in
            print(UserAnswers.cancel.text)
            if let complition = self.complitionBlock { complition(UserAnswers.cancel) }
        }
        ac.addAction(actionYes)
        ac.addAction(actionNo)
        ac.addAction(actionCancel)
        parentVC.present(ac, animated: true, completion: nil)
    }
    
    @objc public static func answersText(_ answer:UserAnswers) -> String {
        return answer.text
    }
    
    private func showReviewWindow(appID:String) {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        } else {
            if let url = URL(string: "http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=\(appID)&pageNumber=0&sortOrdering=1&type=Purple+Software&media=software") {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
}

public extension ReviewManager.UserAnswers {
    var text: String {
        switch self {
        case .yes:
            return "Yes"
        case .no:
            return "No"
        case .cancel:
            return "Cancel"
        }
    }
}


