//
//  TattooDetailsViewController.swift
//  TattoodoCodeAssignment
//
//  Created by Ivan Osypenko on 05/03/2020.
//  Copyright © 2020 iosypenk. All rights reserved.
//

import UIKit

protocol TattooDetailsViewInput: class {
}

class TattooDetailsViewController: UIViewController {
    private var output: TattooDetailsViewOutput?

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
    
}

private extension TattooDetailsViewController {
    func setupView() {
    }
}
