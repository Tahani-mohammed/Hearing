//
//  ARView.swift
//  HearingUI
//
//  Created by Adwa on 17/06/1446 AH.
//
//
//  ARView.swift
//  Screen
//
//  Created by Adwa on 17/06/1446 AH.
//
import SwiftUI
import ARKit
import AVFoundation

struct ARView: UIViewRepresentable {
    @Binding var isSoundDetected: Bool // State binding for sound detection
    var soundThreshold: Float = 0.09   // Configurable threshold for sound detection
    
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
    
    func dismantleUIView(_ uiView: ARSCNView, coordinator: ()) {
        // Stop audio engine and AR session
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        uiView.session.pause()
        print("Audio engine stopped and AR session paused.")
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
            if rms > soundThreshold { // Configurable threshold
                print("Detected sound with RMS: \(rms)")
                self.isSoundDetected = true
                
                // Optional: Add visual indicator
                // addVisualIndicator(to: arView) <-- Pass arView here if needed
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.isSoundDetected = false
                }
            }
        }
    }
    
    // Optional: Add visual AR indicator
    func addVisualIndicator(to arView: ARSCNView) {
        let sphere = SCNSphere(radius: 0.05)
        sphere.firstMaterial?.diffuse.contents = UIColor.red
        let node = SCNNode(geometry: sphere)
        node.position = SCNVector3(0, 0, -0.5) // Half a meter in front of the camera
        arView.scene.rootNode.addChildNode(node)
    }
}


