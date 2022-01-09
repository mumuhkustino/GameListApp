//
//  ErrorView.swift
//  GameListApp
//
//  Created by C-70 on 09/01/22.
//

import SwiftUI

struct ErrorView: View {
    var text: String
    var body: some View {
        VStack{
            Image(systemName: "rectangle.on.rectangle.slash")
                .resizable()
                .frame(width: 300, height: 250.0)
                .padding(EdgeInsets(top: paddingVerticalVerySmall, leading: paddingHorizontalVerySmall, bottom: paddingHorizontalVerySmall, trailing: 0))
                .foregroundColor(.blue)
            
            Text("No \(text) Data or Error")
                .foregroundColor(.blue)
                .lineLimit(2)
                .font(Font.system(size:26, weight: .heavy))
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(text: "Games")
    }
}
