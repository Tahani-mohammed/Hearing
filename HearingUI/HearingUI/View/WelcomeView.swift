//
//  WelcomeView.swift
//  HearingUI
//
//  Created by Adwa on 17/06/1446 AH.
//
import SwiftUI

struct WelcomeView: View {
    @StateObject private var viewModel = WelcomeViewModel() // Initialize the ViewModel

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Title Section
                VStack(alignment: .leading, spacing: 10) {
                    Spacer()
                    
                    Text(viewModel.welcomeData.title)
                        .font(.custom("BebasNeue-Regular", size: 28))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                        .padding(.leading, 50)
                        .padding(.bottom, -30)
                    Spacer()
                    Text(viewModel.welcomeData.subtitle)
                        .font(.custom("BebasNeue-Regular", size: 28))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                        .padding(.leading, 50)
                        .padding(.bottom, 60)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                // Image and Overlay Section
                ZStack {
                    // Background Image
                    Image(viewModel.welcomeData.imageName)
                        .resizable()
                        .frame(width: 400, height: 400)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .padding(.leading, 10)
                    
                    // Overlay Text
                    VStack {
                        Text(viewModel.welcomeData.overlayText)
                            .font(.headline)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 60)
                            .padding(.top, 70)

                        Spacer()
                    }
                }
                .frame(height: 500)

                Spacer()

                // Bottom Navigation Button
                NavigationLink(
                    destination: GuidingView(),
                    isActive: $viewModel.navigateToGuidingView
                ) {
                    Button(action: {
                        viewModel.navigateToNext()
                    }) {
                        ZStack {
                            Circle()
                                .fill(LinearGradient(
                                    gradient: Gradient(colors: [Color.yellow.opacity(0.8), Color.white]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ))
                                .frame(width: 80, height: 80)
                                .shadow(radius: 5)
                            
                            Image(systemName: "arrow.right")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.black)
                        }
                    }
                }
                .padding(.bottom, 40)
                .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()
            }
            .navigationBarBackButtonHidden(true) // Hide the back button
            .background(Color.white)
        }
    }
}

// Preview
struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
