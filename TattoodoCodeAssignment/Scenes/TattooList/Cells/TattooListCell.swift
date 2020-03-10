//
//  TattooListCell.swift
//  TattoodoCodeAssignment
//
//  Created by Ivan Osypenko on 05/03/2020.
//  Copyright © 2020 iosypenk. All rights reserved.
//

import UIKit
import Kingfisher

struct CellViewModel: PostViewModel {
    var likesCount: String
    var commentsCount: String
    var pinsCount: String
    var image: PostImage?
}

class TattooListCell: UITableViewCell {
    var cellHeight: CGFloat = 128
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var likesLabel: UILabel!
    @IBOutlet private weak var commentsLabel: UILabel!
    @IBOutlet private weak var pinsLabel: UILabel!
    
    @IBOutlet private weak var tattooImage: UIImageView!
    
    func configure(with model: CellViewModel) {
        likesLabel.text = "Likes: " + model.likesCount
        commentsLabel.text = "Comments: " + model.commentsCount
        pinsLabel.text = "Pins: " + model.pinsCount
        tattooImage.kf.setImage(with: model.image?.url, options: [.transition(.fade(0.5))])
    }
}
