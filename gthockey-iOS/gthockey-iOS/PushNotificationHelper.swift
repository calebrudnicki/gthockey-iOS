//
//  PushNotificationHelper.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 2/10/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import Firebase
import FirebaseFirestore
import FirebaseMessaging
import UIKit
import UserNotifications

class PushNotificationHelper: NSObject {

    // MARK: Properties

    let userID: String

    // MARK: Init

    init(userID: String) {
        self.userID = userID
        super.init()
    }

    // MARK: Public Functions

    public func registerForPushNotifications() {

        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            Messaging.messaging().delegate = self
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }

        UIApplication.shared.registerForRemoteNotifications()
        updateFirestorePushTokenIfNeeded(with: userID)
    }

    // MARK: Private Functions

    private func updateFirestorePushTokenIfNeeded(with uid: String? = nil) {
        if let token = Messaging.messaging().fcmToken {
            let usersRef = Firestore.firestore().collection("users").document(uid ?? "")
            usersRef.setData(["fcmToken": token], merge: true)
        }
    }

}

extension PushNotificationHelper: MessagingDelegate {

    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print(remoteMessage.appData)
    }
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        updateFirestorePushTokenIfNeeded()
    }

}

extension PushNotificationHelper: UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(response)
    }

}
