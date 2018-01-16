//
//  Photo.swift
//  RxViewModel
//
//  Created by Thuc on 1/13/18.
//  Copyright © 2018 Thuc. All rights reserved.
//

import UIKit
import RxDataSources

struct CurrentPage: Decodable {
    var currentPage: Int
    var feature: String
//    var filters: [String: String]
    var photos: [Photo]
    
    init(currentPage: Int, feature: String, photos: [Photo]) {
        self.currentPage = currentPage
        self.feature = feature
//        self.filters = filters
        self.photos = photos
    }
    
    enum CurrentPageKeys: String, CodingKey {
        case currentpage = "current_page"
        case feature = "feature"
        case filters = "filters"
        case photos = "photos"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CurrentPageKeys.self)
        let currentPage = try container.decode(Int.self, forKey: .currentpage)
        let feature = try container.decode(String.self, forKey: .feature)
//        let filters = try container.decode([String: String].self, forKey: .filters)
        let photos = try container.decode([Photo].self, forKey: .photos)
        self.init(currentPage: currentPage, feature: feature, photos: photos)
    }
}

struct Photo {
    
    var camera: String?
    var createdAt: String?
    var imageUrl: URL?
    
    init(camera: String?, createdAt: String?, imageUrl: URL?) {
        self.camera = camera
        self.createdAt = createdAt
        self.imageUrl = imageUrl
    }
}

extension Photo: Decodable {
    
    enum MyPhotoKeys: String, CodingKey {
        case camera = "camera"
        case created_at = "created_at"
        case image_url = "image_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MyPhotoKeys.self)
        let camera = try? container.decode(String.self, forKey: .camera)
        let createAt = try container.decode(String.self, forKey: .created_at)
        let imageUrl = try container.decode(URL.self, forKey: .image_url)
        self.init(camera: camera, createdAt: createAt, imageUrl: imageUrl)
    }
}

struct SectionOfPhotos {
    var title: String
    var items: [Photo]
}

extension SectionOfPhotos: SectionModelType {
    
    init(original: SectionOfPhotos, items: [Photo]) {
        self = original
        self.items = items
    }
}

