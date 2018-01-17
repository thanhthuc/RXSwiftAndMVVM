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
    var photos: Observable<[SectionOfPhotos]> { get }
    var photosSearch: Driver<[SectionOfPhotos]>? { get }
    
    var filters: Variable<[Int: Bool]> { get }
}

class PhotosViewModel: PhotosViewModelType {
    
    var filters: Variable<[Int : Bool]>
    
    var photos: Observable<[SectionOfPhotos]>
    var photosSearch: Driver<[SectionOfPhotos]>?
    
    let disposedBag = DisposeBag()
    var provider: MoyaProvider<Photos500PX>!
    
    
    
    init() {
        provider = MoyaProvider<Photos500PX>()
        filters = Variable<[Int: Bool]>([:])
        
        let photo = Photo(camera: "Camera", createdAt: "10-10", imageUrl: nil)
        let section = SectionOfPhotos(title: "", items: [photo])
        self.photos = Observable.just([section])
        
        self.photos = Observable<[SectionOfPhotos]>.create { 
            (observer) -> Disposable in
            self.provider.request(.photos(), completion: { (result) in
                if let error = result.error {
                    observer.onError(error) 
                } else {
                    guard let data = result.value?.data else { return }
                    let currentPage = try! JSONDecoder().decode(CurrentPage.self, from: data)
                    print(currentPage)
                    let photos = currentPage.photos
                    let sections = SectionOfPhotos(title: "First section", items: photos)
                    observer.onNext([sections])
                }
            })
            return Disposables.create()
        }
    }
}
