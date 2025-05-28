//
//  SifarisEtBuilder.swift
//  BuilderPatternSnapKit
//
//  Created by User on 28.05.25.
//

import UIKit

class SifarisEtBuilder {
    private let inputdata:SifarisEtInputData
    
    init(inputdata: SifarisEtInputData) {
        self.inputdata = inputdata
    }
    
    func build() -> UIViewController {
        let viewmodel = SifarisEtViewModel(inputdata)
        let viewcontroller = YeniSifarislerViewController(orders: [inputdata], viewModel: viewmodel)
        return viewcontroller
    }
    
}
