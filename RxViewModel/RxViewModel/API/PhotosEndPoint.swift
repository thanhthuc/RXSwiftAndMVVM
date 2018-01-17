//
//  PhotosEndPoint.swift
//  RxViewModel
//
//  Created by Thuc on 1/13/18.
//  Copyright © 2018 Thuc. All rights reserved.
//

import UIKit
import Moya
import RxSwift

struct ErrorType {
    var statusCode: String
    var errMessage: String
}

struct Token {
    
}

extension Reactive where Base: MoyaProvider<Photos500PX> {
    
    func response(_ provider: MoyaProvider<Photos500PX>, target: Photos500PX) -> Observable<Response>  {
        
        return Observable.create({ (observer) in
            
            let task = provider.request(target, completion: { (result) in
                
                switch result {
                case .success(let response):
                    print(response.statusCode)
                    observer.onNext(response)
                    observer.onCompleted()
                case .failure(let error):
                    print(error.localizedDescription)
                    observer.onError(error)
                }
            })
            
            return Disposables.create {
                task.cancel()
            }
        }).retryWhen({ (errors: Observable<MoyaError>) in
            
            return errors.enumerated().flatMap({ (tuple: (retryCount: Int, error: MoyaError)) -> Observable<Token> in
                if /*error.statusCode == 401 && */tuple.retryCount < 1 {
                    // try with refresh token
                }
                return Observable.error(tuple.error)
            })
        })
    }
    
}

//http://sssslide.com/speakerdeck.com/slightair/rxswift-plus-api-request-plus-mvvm



private extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

enum Photos500PX {
    case requestToken()
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
        
        case .requestToken():
            return "oauth/access_token"
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
        
        case .requestToken():
            return .post
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
        switch self {
        case .requestToken():
            return [
                "x_auth_mode": "client_auth",
                "x_auth_password": "",
                "x_auth_username": ""
            ]
        default:
        	return ["consumer_key": "u2Any0rPEGaHb1JYpnSsAWoaRpBPVtEzEyfB8m5D"]    
        }
        
    }
    
    
}
