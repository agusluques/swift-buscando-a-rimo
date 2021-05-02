//
//  Grid.swift
//  Buscando a Rimo
//
//  Created by Agustin Luques on 01/05/2021.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    private var items: Array<Item>
    private var viewForItem: (Item) -> ItemView
    
    init(_ items: Array<Item>, viewForItem: @escaping (Item) -> ItemView){
        self.items = items
        self.viewForItem = viewForItem
    }
    
    var body: some View {
        GeometryReader { geometry in
            ForEach(items) { item in
                let index = items.firstIndex(matching: item)!
                let layout = GridLayout(itemCount: items.count, in: geometry.size)
                
                viewForItem(item)
                    .frame(width: layout.itemSize.width, height: layout.itemSize.height)
                    .position(layout.location(ofItemAt: index))
            }
        }
    }
}
