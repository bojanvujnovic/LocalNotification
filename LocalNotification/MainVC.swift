//
//  ViewController.swift
//  LocalNotification
//
//  Created by Mac on 3/3/17.
//  Copyright © 2017 Boki. All rights reserved.
//

import UIKit
import UserNotifications

class MainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //1.Request Permission
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Notification access granted")
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
    
    @IBAction func notifyButtonTapped(_ sender: Any) {
        self.scheduleNotification(inSeconds: 5) { (success) in
            if success {
                print("Successfully scheduled notification")
            } else {
                print("Error scheduling notification")
            }
        }
    }
    
    func scheduleNotification(inSeconds: TimeInterval, completion: @escaping (_ success: Bool) -> () ) {
        //Notification Content
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title =  Notification.title
        notificationContent.subtitle = Notification.subtitle
        notificationContent.body = Notification.body
        
        //Only For Notification Content Extension
        notificationContent.categoryIdentifier = Notification.category
        
        //Attachment
        let myImage = "lion"
        guard let imageURL = Bundle.main.url(forResource: myImage, withExtension: "png") else {
            completion(false)
            print("There is no URL for image:  \(myImage)")
            return
        }
        var attachment: UNNotificationAttachment
        guard let attach = try? UNNotificationAttachment(identifier: Notification.identifier, url: imageURL, options: .none) else  {
            completion(false)
            print("Notification Attachment error")
            return
        }
        attachment = attach
        notificationContent.attachments = [attachment]
        
        //Notification Trigger
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        //Notification Request
        
        let request = UNNotificationRequest(identifier: Notification.identifier , content: notificationContent, trigger: notificationTrigger)
        
        
        //Add Notification
        UNUserNotificationCenter.current().add(request) { (error) in
            if let _error = error {
                print(_error.localizedDescription)
                completion(false)
            } else {  completion(true) }
        }
    }

    
}

