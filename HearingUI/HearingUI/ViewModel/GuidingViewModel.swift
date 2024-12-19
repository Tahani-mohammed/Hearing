import SwiftUI

class GuidingViewModel: ObservableObject {
    @Published var navigateToARView = false // State to trigger navigation
    @Published var isSoundDetected = false  // State to be passed to ARView
    
    let guidelines = [
        ("RED", "RED: INDICATES AN EMERGENCY THAT \nREQUIRES IMMEDIATE ATTENTION.", Color.red),
        ("YELLOW", "YELLOW: REPRESENTS A WARNING OR NON-URGENT ALERT.", Color.yellow),
        ("GREEN", "GREEN: EVERYTHING IS SAFE.", Color.green),
        ("BLUE", "BLUE: GENERAL NOTIFICATION FOR \nINFORMATION.", Color.blue)
    ]

    // Function to trigger ARView navigation
    func startARView() {
        navigateToARView = true
    }
}
