//
//  Instituicao.swift
//  HackaPoA
//
//  Created by William Hass on 11/6/15.
//  Copyright © 2015 HackaPoA. All rights reserved.
//

import Foundation

class Instituicao: IBMDataObject,IBMDataObjectSpecialization {
    
    dynamic var telefone: String?
    dynamic var ddd: String?
    dynamic var bairro: String?
    dynamic var endereco: String?
    dynamic var localizacao: String?
    dynamic var numero: String?
    dynamic var cep: String?
    dynamic var escola: String?
    dynamic var _id: String?
    
    required override init() {
        super.init()
    }
    
    class func dataClassName() -> String! {
        return "Instituicao"
    }
    
}