//
//  AppDelegate.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 9/25/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift
import Firebase
import FirebaseAuth
import FirebaseFirestore
import Messages
import AppRating

//import Stripe

// MARK: Under Construction

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private let homeCollectionViewController: HomeCollectionViewController = {
        let homeLayout = UICollectionViewFlowLayout()
        homeLayout.sectionInset = UIEdgeInsets(top: 24.0, left: 0.0, bottom: 12.0, right: 0.0)
        let homeCollectionViewController = HomeCollectionViewController(collectionViewLayout: homeLayout)
        return homeCollectionViewController
    }()
    private let scheduleTableViewController = ScheduleTableViewController()
    private let rosterCollectionViewController: RosterCollectionViewController = {
        let rosterLayout = UICollectionViewFlowLayout()
        rosterLayout.sectionInset = UIEdgeInsets(top: 24.0, left: 0.0, bottom: 12.0, right: 0.0)
        let rosterCollectionViewController = RosterCollectionViewController(collectionViewLayout: rosterLayout)
        return rosterCollectionViewController
    }()
    private let shopCollectionViewController: ShopCollectionViewController = {
        let shopLayout = UICollectionViewFlowLayout()
        shopLayout.sectionInset = UIEdgeInsets(top: 24.0, left: 0.0, bottom: 12.0, right: 0.0)
        let shopCollectionViewController = ShopCollectionViewController(collectionViewLayout: shopLayout)
        return shopCollectionViewController
    }()

    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"
    var email: String = ""

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)

        FirebaseApp.configure()

        application.registerForRemoteNotifications()

//        STPPaymentConfiguration.shared().publishableKey = Constants.publishableKey

        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true

        AppRating.appID("1484814696")

        AdminManager().saveAdminUsersOnLaunch()

        let tabBarController = GTHTabBarController()

        let newsNavigationController = UINavigationController(rootViewController: homeCollectionViewController)
        newsNavigationController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house.fill"), tag: 0)

        let scheduleNavigationController = UINavigationController(rootViewController: scheduleTableViewController)
        scheduleNavigationController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "calendar"), tag: 1)

        let rosterNavigationController = UINavigationController(rootViewController: rosterCollectionViewController)
        rosterNavigationController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person.2.fill"), tag: 2)

        let shopNavigatinController = UINavigationController(rootViewController: shopCollectionViewController)
        shopNavigatinController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "cart"), tag: 3)

        let moreNavigationController = UINavigationController(rootViewController: UIViewController())
        moreNavigationController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "line.horizontal.3"), tag: 4)

        tabBarController.setViewControllers([
            newsNavigationController,
            scheduleNavigationController,
            rosterNavigationController,
            shopNavigatinController,
            moreNavigationController
        ], animated: true)

        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
        return true
    }

    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        if userActivity.webpageURL.flatMap(handlePasswordlessSignIn)! {

            if Auth.auth().isSignIn(withEmailLink: userActivity.webpageURL!.absoluteString) {
                AuthenticationManager().signIn(withEmail: self.email, userActivity.webpageURL!.absoluteString, { error in
                    if let error = error {
                        //Could not sign the user in
                        print(error.localizedDescription)
                        return
                    }

                    //Sign in was successful
                    let menuContainerViewController = MenuContainerViewController()
                    self.window?.rootViewController = menuContainerViewController
                    self.window?.makeKeyAndVisible()
                })
                return true
            }
        }
        return false
    }

    private func handlePasswordlessSignIn(withURL url: URL) -> Bool {
        guard let outerComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
            let outerQueryItems = outerComponents.queryItems,
            let outerUrl = URL(string: (outerQueryItems.first { $0.name == "link" }?.value)!)
            else { return false }

        guard let middleComponents = URLComponents(url: outerUrl, resolvingAgainstBaseURL: false),
            let middleQueryItems = middleComponents.queryItems,
            let middleUrl = URL(string: (middleQueryItems.first { $0.name == "continueUrl" }?.value)!)
            else { return false }

        guard let innerComponents = URLComponents(url: middleUrl, resolvingAgainstBaseURL: false),
            let innerQueryItems = innerComponents.queryItems
            else { return false }

        self.email = (innerQueryItems.first { $0.name == "email" }?.value)!
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of
		// temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the
		// application and it begins the transition to the background state.

        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games
		// should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application
		// state information to restore your application to its current state in case it is terminated later.

        // If your application supports background execution, this method is called instead of applicationWillTerminate:
		// when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the
		// changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the
		// application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also
		// applicationDidEnterBackground:.

        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "gthockey_iOS")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this
				// function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is
					locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this
				// function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
      // If you are receiving a notification message while your app is in the background,
      // this callback will not be fired till the user taps on the notification launching the application.
      // TODO: Handle data of notification

      // With swizzling disabled you must let Messaging know about the message, for Analytics
      // Messaging.messaging().appDidReceiveMessage(userInfo)

      // Print message ID.
      if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
      }

      // Print full message.
      print(userInfo)
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
      // If you are receiving a notification message while your app is in the background,
      // this callback will not be fired till the user taps on the notification launching the application.
      // TODO: Handle data of notification

      // With swizzling disabled you must let Messaging know about the message, for Analytics
      // Messaging.messaging().appDidReceiveMessage(userInfo)

      // Print message ID.
      if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
      }

      // Print full message.
      print(userInfo)

      completionHandler(UIBackgroundFetchResult.newData)
    }

}

@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {

    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo

        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)

        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }

        // Print full message.
        print(userInfo)

        // Change this to your preferred presentation option
        completionHandler([.alert, .sound, .badge])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)

        completionHandler()
    }
}

extension AppDelegate: MessagingDelegate {

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")

        let dataDict:[String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }

}
