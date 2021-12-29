//
//  LocationDeniedView.swift
//  CitySights
//
//  Created by Bo-Kai Wang on 2021-12-29.
//

import SwiftUI

struct LocationDeniedView: View {
    private let backgroudColor = Color(red: 34/255, green: 141/255, blue: 138/255)
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("Whoops!")
                .font(.title)
            Text("We need to access your location to provide you with the best sights in the city. You can change your decision at any time in Settings.")
            Spacer()
            Button {
                // Open Settings by getting the settings url
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    if UIApplication.shared.canOpenURL(url) {
                        // If we can open this settings url, then open it
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            } label: {
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(height: 48)
                        .cornerRadius(10)
                    Text("Go to Settings")
                        .bold()
                        .foregroundColor(backgroudColor)
                }
            }
            Spacer()
        }
        .padding()
        .foregroundColor(.white)
        .multilineTextAlignment(.center)
        .background(backgroudColor)
        .ignoresSafeArea()
    }
}

struct LocationDeniedView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDeniedView()
    }
}