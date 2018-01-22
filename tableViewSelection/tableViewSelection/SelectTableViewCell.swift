//
//  SelectTableViewCell.swift
//  tableViewSelection
//
//  Created by Thuc on 1/18/18.
//  Copyright © 2018 Thuc. All rights reserved.
//

import UIKit

class SelectTableViewCell: UITableViewCell {

    @IBOutlet weak var selectImageView: UIImageView!
    
    var isSelectedCustom: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
