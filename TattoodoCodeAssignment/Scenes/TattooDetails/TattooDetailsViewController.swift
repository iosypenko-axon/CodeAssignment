//
//  TattooDetailsViewController.swift
//  TattoodoCodeAssignment
//
//  Created by Ivan Osypenko on 05/03/2020.
//  Copyright © 2020 iosypenk. All rights reserved.
//

import UIKit
import Kingfisher

protocol TattooDetailsViewInput: class {
    func updateView(with model: DetailsViewModel)
    func showError(description: String)
}

struct DetailsViewModel: PostViewModel {
    var likesCount: String
    var commentsCount: String
    var pinsCount: String
    var image: PostImage?
    var description: String
}

class TattooDetailsViewController: UIViewController {
    private var output: TattooDetailsViewOutput?

    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var tattooImage: UIImageView!
    @IBOutlet private weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var likesLabel: UILabel!
    @IBOutlet private weak var commentsLabel: UILabel!
    @IBOutlet private weak var pinsLabel: UILabel!
   
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        output?.didLoad()
    }
}

// MARK: - Public methods
extension TattooDetailsViewController {
    func attach(output: TattooDetailsViewOutput) {
        self.output = output
    }
}

extension TattooDetailsViewController: TattooDetailsViewInput {
    func updateView(with model: DetailsViewModel) {
        likesLabel.text = "Likes: " + model.likesCount
        commentsLabel.text = "Comments: " + model.commentsCount
        pinsLabel.text = "Pins: " + model.pinsCount
        tattooImage.kf.setImage(with: model.image?.url, options: [.transition(.fade(0.5))])
        imageHeightConstraint.constant = model.getAdjustedImageHeight(for: view.bounds.width)
        descriptionLabel.text = model.description
    }
    
    func showError(description: String) {
        let alertController = UIAlertController(title: "Error", message: description, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
    }
}

private extension TattooDetailsViewController {
    func setupView() {
        scrollView.contentInset.bottom = 30
        likesLabel.text = nil
        commentsLabel.text = nil
        pinsLabel.text = nil
        descriptionLabel.text = nil
    }
}
