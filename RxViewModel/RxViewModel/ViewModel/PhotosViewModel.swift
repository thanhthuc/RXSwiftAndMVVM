//
//  PhotosViewModel.swift
//  RxViewModel
//
//  Created by Thuc on 1/13/18.
//  Copyright © 2018 Thuc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Moya
import RxOptional

protocol PhotosViewModelType {
    var photos: Observable<[Photo]>? { get }
    var photosSearch: Observable<[Photo]>? { get }
}

class PhotosViewModel: PhotosViewModelType {
    var photos: Observable<[Photo]>?
    var photosSearch: Observable<[Photo]>?
    
    
    let disposedBag = DisposeBag()
    var provider: MoyaProvider<Photos500PX>!
    
    
    init() {
        provider = MoyaProvider<Photos500PX>()
        
        provider
            .rx
            .request(.photos())
            .subscribe { event in 
                switch event {
                    
                case .success(let response):
                    print(response.data)
                    
                    let currentPage = try! JSONDecoder().decode(CurrentPage.self, from: response.data)
                    print(currentPage)
                    //self.photos = Observable.just(photos)
                case .error(let error):
                    print(error)
                    self.photos = Observable.just([])
                }
            }
            .disposed(by: disposedBag)
        
    }
}
