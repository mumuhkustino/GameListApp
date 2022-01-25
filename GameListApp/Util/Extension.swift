//
//  Extension.swift
//  GameListApp
//
//  Created by C-70 on 09/01/22.
//

import Foundation
import SwiftUI
import CoreData

extension Float {
    func format() -> String {
        return String(format: "%.2f", self)
    }
}

extension NSManagedObjectContext {
    static var current: NSManagedObjectContext{
        return PersistenceContainer.persistentContainer.viewContext
    }
}

@ViewBuilder
func placeHolderImage(width: CGFloat, height: CGFloat) -> some View {
    HStack(alignment: .center) {
        Image(systemName: "photo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: width, height: height)
            .foregroundColor(.gray)
    }
}
