//
//  StripeClient.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 12/5/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import Foundation
//import Alamofire
import Stripe

// MARK: Under Construction (not used)

//enum Result {
//  case success
//  case failure(Error)
//}

class StripeClient: NSObject, STPCustomerEphemeralKeyProvider {
    enum APIError: Error {
        case unknown

        var localizedDescription: String {
            switch self {
            case .unknown:
                return "Unknown error"
            }
        }
    }

    private let baseURL = "https://gthockey-ios.herokuapp.com/"

    static let shared = StripeClient()

    func createPaymentIntent(products: [CartItem], shippingMethod: PKShippingMethod?, country: String? = nil, completion: @escaping ((Result<String, Error>) -> Void)) {
        let url = URL(string: baseURL)!.appendingPathComponent("create_payment_intent")
//        var params: [String: Any] = [:]
//            "metadata": [
//                // example-ios-backend allows passing metadata through to Stripe
//                "amount": 1000,
//            ],
//        ]
        var params: [String: Any] = [
            "metadata": [
                // example-ios-backend allows passing metadata through to Stripe
                "payment_request_id": "B3E611D1-5FA1-4410-9CEC-00958A5126CB",
            ],
        ]
        var total = 0.0
        for product in products {
            total += (100 * product.getPrice())
        }

        params["amount"] = total
        if let shippingMethod = shippingMethod {
            params["shipping"] = shippingMethod.identifier
        }
        params["country"] = country
        let jsonData = try? JSONSerialization.data(withJSONObject: params)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let data = data,
                let json = ((try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]) as [String : Any]??),
                let secret = json?["secret"] as? String else {
                    completion(.failure((error ?? nil)!))
                    return
            }
            completion(.success(secret))
        })
        task.resume()
    }

    func createCustomerKey(withAPIVersion apiVersion: String, completion: @escaping STPJSONResponseCompletionBlock) {
        let url = URL(string: baseURL)!.appendingPathComponent("ephemeral_keys")

        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!

        urlComponents.queryItems = [URLQueryItem(name: "api_version", value: apiVersion)]
        let params: [String: Any] = ["description": "My cool user"]
        let jsonData = try? JSONSerialization.data(withJSONObject: params)
        var request = URLRequest(url: urlComponents.url!)

//        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
//        request.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let data = data,
                let json = ((try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]) as [String : Any]??) else {
                completion(nil, error)
                return
            }
            completion(json, nil)
        })
        task.resume()
    }

}
