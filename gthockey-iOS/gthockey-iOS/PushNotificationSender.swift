//
//  PushNotificationSender.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 2/9/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import Foundation

class PushNotificationSender {

    init() {}

    // MARK: Public Functions

    public func sendPushNotification(to tokens: [String], title: String, body: String, completion: @escaping () -> Void) {
        let urlString = "https://fcm.googleapis.com/fcm/send"
        let url = NSURL(string: urlString)!
        let paramString: [String : Any] = ["registration_ids" : tokens,
                                           "notification" : ["title" : title, "body" : body],
                                           "data" : ["user" : "test_id"]
        ]

        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject:paramString, options: [.prettyPrinted])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("key=AAAAUgiuQUM:APA91bFZvhw4nZzZUb32_E_hr3SI1seLNLxHiYGa8yZjwOLUrhSdViK-Sb4bwwveR9bXq-1TR2_xFCNXUoFJajPp6YcKLDGpADoq7BlBmvIU-mGxlH_SjyX3mpZ0jajFzEf0EoiZgd3w", forHTTPHeaderField: "Authorization")
        let task =  URLSession.shared.dataTask(with: request as URLRequest)  { (data, response, error) in
            do {
                if let jsonData = data {
                    if let jsonDataDict  = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] {
                        NSLog("Received data:\n\(jsonDataDict))")
                    }
                }
            } catch let err as NSError {
                print(err.debugDescription)
            }
        }
        task.resume()
        completion()
    }
    
}


