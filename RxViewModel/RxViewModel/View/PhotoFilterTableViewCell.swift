//
//  PhotoTableViewCell.swift
//  RxViewModel
//
//  Created by Thuc on 1/13/18.
//  Copyright © 2018 Thuc. All rights reserved.
//

import UIKit

class PhotoFilterTableViewCell: UITableViewCell, BindableView, ReusableView, NibProviable {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var selectButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

extension PhotoFilterTableViewCell {
    
    typealias V = Photo
    
    func bindViewModel(viewModel: Photo) {
        
    }
}
