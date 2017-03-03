//
//  NotificationViewController.swift
//  MyContentExtension
//
//  Created by Mac on 3/3/17.
//  Copyright © 2017 Boki. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet weak var imageView: UIImageView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        guard let attachment = notification.request.content.attachments.first else {
            return
        }
        if attachment.url.startAccessingSecurityScopedResource() {
            if let imageData = try? Data(contentsOf: attachment.url) {
                if var image = UIImage(data:  imageData) {
                    image = image.resizeImage(newWidth: 300 )
                    imageView.image = image
                }
            }
        }
    }
    
    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        if response.actionIdentifier == NotificatioN.fistIdentifier {
            completion(.dismissAndForwardAction)
        } else if  response.actionIdentifier == NotificatioN.dismissIdentifier {
            completion(.dismissAndForwardAction)
        }
    }

}
