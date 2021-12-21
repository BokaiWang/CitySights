//
//  ContentView.swift
//  CitySights
//
//  Created by Bo-Kai Wang on 2021-12-19.
//

import SwiftUI

struct LaunchView: View {
    @EnvironmentObject var model:ContentModel
    var body: some View {
        // Detect the authorization status of geolocating the user
        if model.authorizationState == .notDetermined {
            // If undetermined, show onboarding
        }
        
        else if model.authorizationState == .authorizedWhenInUse || model.authorizationState == .authorizedAlways {
            // If approved, show home view
            HomeView()
        }
        
        else {
            // If denied, show denied view
        }
        
        
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
