import SwiftUI

struct GuidingView: View {
    @StateObject private var viewModel = GuidingViewModel() // ViewModel instance
    @Environment(\.presentationMode) var presentationMode // For navigation back

    var body: some View {
        ZStack {
            VStack {
                // Image Section
               
                // Title Section
                Text("COLOR INDICATOR\nGUIDELINES")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .padding(.top, 70) // Slight space between image and text

                Image("GS") // Replace with your asset name
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350, height: 300)
                    .padding(.top, -50)
                
                // Guidelines Section
                VStack(alignment: .leading, spacing: 15) {
                    ForEach(viewModel.guidelines, id: \.0) { _, text, color in
                        HStack {
                            Circle()
                                .fill(color)
                                .frame(width: 12, height: 12)

                            Text(text)
                                .font(.subheadline)
                                .foregroundColor(.black)
                        }
                    }
                }
                .padding(.leading, 20)

                Spacer()

                // Navigation Button to ARView
                NavigationLink(
                    destination: ARView(isSoundDetected: $viewModel.isSoundDetected),
                    isActive: $viewModel.navigateToARView
                ) {
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
                .onTapGesture {
                    viewModel.navigateToARView = true
                }
                .padding(.bottom, 90)
            }

            // Custom Back Button
            VStack {
                HStack {
                    Button(action: { presentationMode.wrappedValue.dismiss() }) {
                        HStack {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                            Text("")
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.leading, 16)
                    Spacer()
                }
                .padding(.top, 90)
                Spacer()
            }
        }
        .navigationBarHidden(true) // Hide default navigation bar
        .navigationBarBackButtonHidden(true) // Hide default back button
        .edgesIgnoringSafeArea(.all)
    }
}

// Corrected PreviewProvider
struct GuidingView_Previews: PreviewProvider {
    static var previews: some View {
        GuidingView()
    }
}
