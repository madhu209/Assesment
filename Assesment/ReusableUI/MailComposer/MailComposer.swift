//
//  MailCompose.swift
//  Assesment
//
//  Created by Madhusudhan on 11/09/20.
//  Copyright © 2020 mLabs. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

internal final class MailComposer: NSObject {

    static let shared = MailComposer()
    
    func sendEmail(_ controller: UIViewController) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["hello@xetone.com"])
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)

            controller.present(mail, animated: true)
        } else {
            // show failure alert
            AlertManager.shared.showAlert("Mail not configured in Device")
        }
    }
    
    
    
}

extension MailComposer: MFMailComposeViewControllerDelegate {
        
    internal func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
}


