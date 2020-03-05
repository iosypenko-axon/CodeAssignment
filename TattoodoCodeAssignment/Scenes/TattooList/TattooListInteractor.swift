//
//  TattooListInteractor.swift
//  TattoodoCodeAssignment
//
//  Created by Ivan Osypenko on 05/03/2020.
//  Copyright © 2020 iosypenk. All rights reserved.
//

protocol TattooListInteractorInput {
}

protocol TattooListInteractorOutput: AnyObject {
}

class TattooListInteractor {
    weak var output: TattooListInteractorOutput!
}

// MARK: - Public methods
extension TattooListInteractor {
    func attach(output: TattooListInteractorOutput) {
        self.output = output
    }
}

extension TattooListInteractor: TattooListInteractorInput {
   
}

