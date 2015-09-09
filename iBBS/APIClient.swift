
//  APIClient.swift
//  iBBS
//
//  Created by Augus on 9/2/15.
//  Copyright © 2015 iAugus. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

let APIRootURL = "http://yabbs.sinaapp.com/index.php/Home/Api/"
//let APIRootURL = "https://www.v2ex.com/api/"

class APIClient {
    class var SharedAPIClient: APIClient {
        struct Static{
            static let sharedInstance = APIClient()
        }
        return Static.sharedInstance
    }
    
    func getJSONData(path: String, parameters: [String : AnyObject]?, success: (JSON) -> Void, failure: (NSError) -> Void) {
        Alamofire.request(.GET, APIRootURL + path, parameters: parameters)
            .responseSwiftyJSON { (request, response, json, error) in
                if let err = error {
                    failure(err)
                } else {
                    success(json)
                }
        }
    }

    func getLatestTopics(success: (JSON) -> Void, failure: (NSError) -> Void) {
        self.getJSONData("latest", parameters: nil, success: success, failure: failure)
    }
    
    func getLatestTopics(nodeID: NSString, success: (JSON) -> Void, failure: (NSError) -> Void) {
        let dict = ["node_id": nodeID]
        self.getJSONData("topics/latest.json", parameters: dict, success: success, failure: failure)
    }

    func getReplies(postID: NSString, success: (JSON) -> Void, failure: (NSError) -> Void) {
        let dict = ["postId": postID]
        self.getJSONData("comments", parameters: dict, success: success, failure: failure)
    }
    
    func getNodes(success: (JSON) -> Void, failure: (NSError) -> Void) {
        self.getJSONData("nodes/all.json", parameters: nil, success: success, failure: failure)
    }
}