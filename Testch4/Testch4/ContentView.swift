




import SwiftUI

struct ContentView: View {
    @State private var isSoundDetected = false // متغير حالة الصوت
    @State private var showBubbles = false     // متغير للتحكم في ظهور الفقاعات
    
    var body: some View {
        ZStack {
            ARView(isSoundDetected: $isSoundDetected)
                .edgesIgnoringSafeArea(.all)
            
            if showBubbles {
                // مجموعة فقاعات تتحرك لأعلى
                ForEach(0..<10, id: \.self) { index in
                    BubbleView()
                        .offset(x: CGFloat.random(in: -100...100), y: CGFloat.random(in: -100...0))
                        .scaleEffect(CGFloat.random(in: 0.5...1.5)) // أحجام مختلفة
                        .opacity(Double.random(in: 0.5...1.0)) // شفافية عشوائية
                }
            }
        }
        .onChange(of: isSoundDetected) { newValue in
            if newValue {
                showBubbles = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { // مدة ظهور الفقاعات
                    showBubbles = false
                }
            }
        }
        .animation(.easeOut(duration: 1.5), value: showBubbles) // تأثير حركة الفقاعات
    }
}

struct BubbleView: View {
    var body: some View {
        Circle()
            .fill(Color.red.opacity(0.5))
            .frame(width: CGFloat.random(in: 30...60), height: CGFloat.random(in: 30...60))
            .overlay(
                Circle()
                    .stroke(Color.white, lineWidth: 2)
            )
    }
}
