//
//  Extension.swift
//  GameListApp
//
//  Created by C-70 on 09/01/22.
//

import SwiftUI
import CoreData

extension Float {
    func format() -> String {
        return String(format: "%.2f", self)
    }
}

extension NSManagedObjectContext {
    static var mocCurrent: NSManagedObjectContext{
        return PersistenceContainer.containerHelper.viewContext
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
