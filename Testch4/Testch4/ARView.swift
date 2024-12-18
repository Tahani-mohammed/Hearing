

import SwiftUI
import ARKit
import AVFoundation

struct ARView: UIViewRepresentable {
    @Binding var isSoundDetected: Bool // رابط لمتغير حالة الصوت

    let audioEngine = AVAudioEngine()
    
    func makeUIView(context: Context) -> ARSCNView {
        let arView = ARSCNView()
        arView.automaticallyUpdatesLighting = true
        arView.showsStatistics = true
        
        startAudioRecognition()
        
        return arView
    }
    
    func updateUIView(_ uiView: ARSCNView, context: Context) {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        uiView.session.run(configuration)
    }
    
    func startAudioRecognition() {
        let inputNode = audioEngine.inputNode
        let audioFormat = inputNode.outputFormat(forBus: 0)
        
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: audioFormat) { (buffer, time) in
            self.analyzeAudio(buffer: buffer)
        }
        
        do {
            audioEngine.prepare()
            try audioEngine.start()
            print("Audio engine started!")
        } catch {
            print("Error starting audio engine: \(error.localizedDescription)")
        }
    }
    
    func analyzeAudio(buffer: AVAudioPCMBuffer) {
        let channelData = buffer.floatChannelData?[0]
        let channelDataArray = Array(UnsafeBufferPointer(start: channelData, count: Int(buffer.frameLength)))
        
        let rms = sqrt(channelDataArray.map { $0 * $0 }.reduce(0, +) / Float(channelDataArray.count))
        DispatchQueue.main.async {
            if rms > 0.09{ // عتبة التعرف على الصوت
                print("Detected sound with RMS: \(rms)")
                self.isSoundDetected = true
                
                // إعادة ضبط الحالة بعد نصف ثانية
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.isSoundDetected = false
                }
            }
        }
    }
} 
