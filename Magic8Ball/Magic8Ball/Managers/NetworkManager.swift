//
//  NetworkManager.swift
//  Magic8Ball
//
//  Created by mac on 23.10.2021.
//

import Foundation

class NetworkManager {
    class func getMagicAnswer(completion: ((String?) -> Void)?) {
        let url = URL(string: "https://8ball.delegator.com/magic/JSON/42")!

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data,
                  let dictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                  let magic = dictionary["magic"] as? [String: Any],
                  let answer = magic["answer"] as? String else {
                
                completion?(nil)
                return
            }
            
            completion?(answer)
        }

        task.resume()
    }
}
