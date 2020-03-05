//
//  TattooDetailsInteractor.swift
//  TattoodoCodeAssignment
//
//  Created by Ivan Osypenko on 05/03/2020.
//  Copyright © 2020 iosypenk. All rights reserved.
//

import Foundation

protocol TattooDetailsInteractorInput {
}

protocol TattooDetailsInteractorOutput: AnyObject {
}

class TattooDetailsInteractor {
    weak var output: TattooDetailsInteractorOutput!
}

// MARK: - Public methods
extension TattooDetailsInteractor {
    func attach(output: TattooDetailsInteractorOutput) {
        self.output = output
    }
}

extension TattooDetailsInteractor: TattooDetailsInteractorInput {
   
}

