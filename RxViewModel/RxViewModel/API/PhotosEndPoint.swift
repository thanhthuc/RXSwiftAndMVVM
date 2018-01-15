//
//  PhotosEndPoint.swift
//  RxViewModel
//
//  Created by Thuc on 1/13/18.
//  Copyright © 2018 Thuc. All rights reserved.
//

import UIKit
import Moya

private extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

enum Photos500PX {
    case photos()
    case search(name: String) 
    case filter(tags: String)
}

extension Photos500PX: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.500px.com/v1/")!
    }
    
    var path: String {
        switch self {
        case .photos:
            return "photos/"
        case .filter(let tags):
            return "photos/:id/\(tags.URLEscapedString)"
        case .search(let name):
            return "photos/search/\(name.URLEscapedString)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .photos:
            return .get
        case .filter:
            return .post
        case .search:
            return .post
        }
    }
    
    var sampleData: Data {
        return "{\"login\": \"name\", \"id\": 100}".data(using: .utf8)!
    }
    
    var task: Task {
        return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/x-www-form-urlencoded"]
    }
    
    var params: [String: String] {
        return ["consumer_key": "u2Any0rPEGaHb1JYpnSsAWoaRpBPVtEzEyfB8m5D"]
    }
    
    
}
