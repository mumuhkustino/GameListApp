//
//  AboutView.swift
//  GameListApp
//
//  Created by C-70 on 09/01/22.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack {
            Text("About")
                .foregroundColor(.black)
                .bold()
                .font(Font.system(size:25))
            Image(
                "Mumuh")
                .resizable()
                .frame(width: 180, height: 240)
            Text("Mumuh Kustino Muharram")
                .foregroundColor(.black)
                .font(Font.system(size:20))
                .padding(EdgeInsets(top: paddingVerticalVerySmall, leading: 0, bottom: 0, trailing: 0))
            Text("Junior Mobile Developer")
                .foregroundColor(.black)
                .font(Font.system(size:17))
                .padding(EdgeInsets(top: paddingVerticalVerySmall, leading: 0, bottom: 0, trailing: 0))
            
            Text("Keahlian")
                .foregroundColor(.black)
                .bold()
                .font(Font.system(size:17))
                .padding(EdgeInsets(top: paddingVerticalLarge, leading: 0, bottom: paddingVerticalVerySmall, trailing: 0))
            HStack {
                Text("IDE (Netbeans, Android Studio, Visual Studio Code)")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .frame(width: UIScreen.main.bounds.width / 2, height: 50, alignment: .leading)
                    .font(Font.system(size:15))
                ProgressView(value: 75, total: 100)
            }.padding(EdgeInsets(top: 0, leading: paddingHorizontalMedium, bottom: 0, trailing: paddingHorizontalMedium))
            HStack {
                Text("Mobile Programming (Java, Kotlin, Dart)")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .frame(width: UIScreen.main.bounds.width / 2, height: 50, alignment: .leading)
                    .font(Font.system(size:15))
                ProgressView(value: 75, total: 100)
            }.padding(EdgeInsets(top: 0, leading: paddingHorizontalMedium, bottom: 0, trailing: paddingHorizontalMedium))
            HStack {
                Text("Modelling Tools (ERD, Class Diagram ,BPMN, Sequence Diagram)")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .frame(width: UIScreen.main.bounds.width / 2, height: 75, alignment: .leading)
                    .font(Font.system(size:15))
                ProgressView(value: 50, total: 100)
            }.padding(EdgeInsets(top: 0, leading: paddingHorizontalMedium, bottom: 0, trailing: paddingHorizontalMedium))
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
