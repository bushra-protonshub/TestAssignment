//
//  WebserviceHandler.swift
//  ProtonsHubTestAssignment
//
//  Created by Bushra on 09/02/20.
//  Copyright © 2020 Softinator. All rights reserved.
//

import Alamofire

class WebServiceHandler: NSObject {

    static var indexOfPageToRequest = 1
    
    class func getHits(completion: @escaping ([Hits]?) -> ()) {
        let hitURL: String = "https://hn.algolia.com/api/v1/search_by_date?tags=story&page=\(indexOfPageToRequest)"
        Alamofire.request(hitURL, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                switch response.result{
                case .success( _):
                    let json = try! JSONSerialization.jsonObject(with: response.data ?? Data(), options: [])
                    let jsonDict = json as? Dictionary<String, AnyObject> ?? [:]
                    let hitsData = jsonDict["hits"]
                    do{
                        let jsonResponse = try JSONSerialization.data(withJSONObject:hitsData as Any)
                        let hits = try JSONDecoder().decode([Hits].self, from: jsonResponse)
                        completion(hits)
                    } catch let parsingError {
                        print("Error", parsingError)
                    }
                case .failure(let error):
                    print("error \(error)")
                }
        }
    }
}
