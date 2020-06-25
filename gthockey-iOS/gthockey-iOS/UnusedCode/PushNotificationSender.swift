//
//  PushNotificationSender.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 2/9/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

//import Foundation
//
//class PushNotificationSender {
//
//    init() {}
//
//    // MARK: Public Functions
//
//    /**
//     Sends a push notification to a group of users.
//
//     - Parameter tokens: A list of the FCM tokens for targeted users of the push notification.
//     - Parameter title: The title of the push notification.
//     - Parameter body: The content of the push notification.
//
//     - Completion: A block to execute once the user's properties have been retrieved.
//     */
//    public func sendNotification(to tokens: [String], title: String, body: String, completion: @escaping () -> Void) {
//        let paramDict: [String : Any] = ["registration_ids" : tokens,
//                                           "notification" : ["title" : title, "body" : body],
//                                           "data" : ["user" : "test_id"]]
//
//        send(with: paramDict, completion: {
//            completion()
//        })
//    }
//
//    /**
//     Sends a push notification to one particular users
//
//     - Parameter token: The FCM token for single user targeted for the push notification.
//     - Parameter title: The title of the push notification.
//     - Parameter body: The content of the push notification.
//
//     - Completion: A block to execute once the user's properties have been retrieved.
//     */
//    public func sendNotification(to token: String, title: String, body: String, completion: @escaping () -> Void) {
//        let paramDict: [String : Any] = ["to" : token,
//                                         "notification" : ["title" : title, "body" : body],
//                                         "data" : ["user" : "test_id"]]
//
//        send(with: paramDict, completion: {
//            completion()
//        })
//    }
//
//    // MARK: Private Functions
//
//    private func send(with dict: [String: Any], completion: @escaping () -> Void)  {
//        let url = NSURL(string: "https://fcm.googleapis.com/fcm/send")!
//
//        let request = NSMutableURLRequest(url: url as URL)
//        request.httpMethod = "POST"
//        request.httpBody = try? JSONSerialization.data(withJSONObject: dict, options: [.prettyPrinted])
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("key=AAAAUgiuQUM:APA91bFZvhw4nZzZUb32_E_hr3SI1seLNLxHiYGa8yZjwOLUrhSdViK-Sb4bwwveR9bXq-1TR2_xFCNXUoFJajPp6YcKLDGpADoq7BlBmvIU-mGxlH_SjyX3mpZ0jajFzEf0EoiZgd3w", forHTTPHeaderField: "Authorization")
//        let task =  URLSession.shared.dataTask(with: request as URLRequest)  { (data, response, error) in
//            do {
//                if let jsonData = data {
//                    if let jsonDataDict  = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] {
//                        NSLog("Received data:\n\(jsonDataDict))")
//                    }
//                }
//            } catch let err as NSError {
//                print(err.debugDescription)
//            }
//        }
//        task.resume()
//        completion()
//    }
//    
//}
