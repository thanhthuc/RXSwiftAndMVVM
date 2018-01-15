//
//  PhotoCollectionViewCellTableViewCell.swift
//  RxViewModel
//
//  Created by Thuc on 1/13/18.
//  Copyright © 2018 Thuc. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell, BindableView, ReusableView, NibProviable {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loveButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

extension PhotoCollectionViewCell {
    
    typealias V = Photo
    
    func bindViewModel(viewModel: Photo) {
        let data = NSData(contentsOf: viewModel.imageUrl)
        imageView.image = UIImage(data: data! as Data)
    }
}
