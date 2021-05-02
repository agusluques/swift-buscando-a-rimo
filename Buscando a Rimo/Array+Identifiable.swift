//
//  Array+Identifiable.swift
//  Buscando a Rimo
//
//  Created by Agustin Luques on 01/05/2021.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching element: Element) -> Int? {
        self.firstIndex { $0.id == element.id}
    }
}
