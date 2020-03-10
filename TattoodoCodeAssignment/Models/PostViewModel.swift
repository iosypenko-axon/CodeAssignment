//
//  PostViewModel.swift
//  TattoodoCodeAssignment
//
//  Created by Ivan Osypenko on 10/03/2020.
//  Copyright © 2020 iosypenk. All rights reserved.
//

import UIKit

protocol PostViewModel {
    var likesCount: String { get set }
    var commentsCount: String { get set }
    var pinsCount: String { get set }
    var image: PostImage? { get set }
    
    func getAdjustedImageHeight(for newWidth: CGFloat) -> CGFloat
}

extension PostViewModel {
    func getAdjustedImageHeight(for newWidth: CGFloat) -> CGFloat {
        let defaultHeight: Int = 250
        guard let imageWidth = image?.width, let imageHeight = image?.height, imageHeight != 0 else { return CGFloat(image?.width ?? defaultHeight) }
        let aspectRatio = CGFloat(imageWidth) / CGFloat(imageHeight)
        return newWidth / aspectRatio
    }
}
