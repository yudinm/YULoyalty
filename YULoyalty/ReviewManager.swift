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
    
    @objc public enum Answers : Int {
        case yes = 1
        case no = 2
        case cancel = 0
    }
    
    @objc public var complitionBlock: ((_ answer:Answers) -> ())?
    
    @objc public func askForReview(parentVC:UIViewController) {
        let actitle = "Do you like our App?"
        let acmessage = ""
        let ac:UIAlertController = UIAlertController(title: actitle, message: acmessage, preferredStyle: .alert)
        
        let actionYes:UIAlertAction = UIAlertAction(title: Answers.yes.text, style: .default) { action in
            print(Answers.yes.text)
            self.showReviewWindow()
            if let complition = self.complitionBlock { complition(Answers.yes) }
        }
        let actionNo:UIAlertAction = UIAlertAction(title: Answers.no.text, style: .default) { action in
            print(Answers.no.text)
            if let complition = self.complitionBlock { complition(Answers.no) }
        }
        let actionCancel:UIAlertAction = UIAlertAction(title: Answers.cancel.text, style: .cancel) { action in
            print(Answers.cancel.text)
            if let complition = self.complitionBlock { complition(Answers.cancel) }
        }
        ac.addAction(actionYes)
        ac.addAction(actionNo)
        ac.addAction(actionCancel)
        parentVC.show(ac, sender: parentVC)
    }
    
    @objc public static func answersText(_ answer:Answers) -> String {
        return answer.text
    }
    
    private func showReviewWindow() {
        SKStoreReviewController.requestReview()
    }

}

public extension ReviewManager.Answers {
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


