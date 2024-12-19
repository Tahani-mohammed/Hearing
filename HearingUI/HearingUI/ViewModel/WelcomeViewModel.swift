import SwiftUI

class WelcomeViewModel: ObservableObject {
    // Navigation state
    @Published var navigateToGuidingView = false
    
    // Static data for the view
    let welcomeData = WelcomeModel(
        title: "YOUR GUIDE TO HEAR",
        subtitle: "CLARITY AND SAFETY",
        overlayText: "LIVE YOUR LIFE WITH CONFIDENCE \nAND FREEDOM",
        imageName: "GG" // Replace with the correct image asset name
    )
    
    // Method to trigger navigation
    func navigateToNext() {
        navigateToGuidingView = true
    }
}

//
//  WelcomeViewModel.swift
//  HearingUI
//
//  Created by Adwa on 17/06/1446 AH.
//

