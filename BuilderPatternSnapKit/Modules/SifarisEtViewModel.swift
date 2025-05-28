//
//  SifarisEtViewModel.swift
//  BuilderPatternSnapKit
//
//  Created by User on 28.05.25.
//

import UIKit

protocol SifarisEtDelegate: AnyObject {
    func render(_ state: SifarisEtState)
}

enum SifarisEtState {
    case loading(mehsulLinki: String, mebleg: String, kargo: String, sherh: String, toplamMebleg: String)
    case success
    case failure(error: String)
}

class SifarisEtViewModel {
    private let inputdata :SifarisEtInputData
    
    private var delegate:SifarisEtDelegate?
    
    
    
    init(_ inputdata:SifarisEtInputData){
        self.inputdata = inputdata
    }
    
    func subscribe(_ delegate: SifarisEtDelegate){
        self.delegate = delegate
    }
    
    func fetchData(){
        delegate?.render(.loading(mehsulLinki: inputdata.mehsulLinki,
                                  mebleg: inputdata.mebleg,
                                  kargo: inputdata.kargo,
                                  sherh: inputdata.sherh,
                                  toplamMebleg: inputdata.toplamMebleg))
    }
}
