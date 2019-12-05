//
//  StripeClient.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 12/5/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import Foundation
import Alamofire
import Stripe

enum Result {
  case success
  case failure(Error)
}

final class StripeClient {

  static let shared = StripeClient()

  private init() {}

  private lazy var baseURL: URL = {
    guard let url = URL(string: Constants.baseURLString) else {
      fatalError("Invalid URL")
    }
    return url
  }()

  func completeCharge(with token: STPToken, amount: Double, completion: @escaping (Result) -> Void) {
    // 1
    let url = baseURL.appendingPathComponent("charge")
    // 2
    let params: [String: Any] = [
      "token": token.tokenId,
      "amount": amount,
      "currency": Constants.defaultCurrency,
      "description": Constants.defaultDescription
    ]
    // 3
    Alamofire.request(url, method: .post, parameters: params)
      .validate(statusCode: 200..<300)
      .responseString { response in
        switch response.result {
        case .success:
          completion(Result.success)
        case .failure(let error):
          completion(Result.failure(error))
        }
    }
  }

}
