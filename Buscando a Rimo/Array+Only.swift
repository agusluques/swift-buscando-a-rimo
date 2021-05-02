//
//  Array+Only.swift
//  Buscando a Rimo
//
//  Created by Agustin Luques on 01/05/2021.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
