//
//  ViewModel.swift
//  slopemeter
//
//  Created by Andrii Iliukhin on 12/16/23.
//

import Foundation
import CoreMotion

class SlopeViewModel: ObservableObject {
    private var motionManager = CMMotionManager()
    @Published var slopeAngle: Double = 0.0
    @Published var slopeAnglePitch: Double = 0.0
    @Published var slopeAngleRoll: Double = 0.0
    private var baselineAngle: Double = 0.0
    private var baselineAnglePitch: Double = 0.0
    private var baselineAngleRoll: Double = 0.0

    init() {
        startMotionUpdates()
    }

    func calibrate() {
        baselineAngle = slopeAngle
        baselineAnglePitch = slopeAnglePitch
        baselineAngleRoll = slopeAngleRoll
    }

    private func startMotionUpdates() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 1.0 / 60.0
            motionManager.startDeviceMotionUpdates(to: .main) { [weak self] (data, error) in
                guard let data = data, error == nil else { return }
                let angleInDegrees = data.attitude.pitch * 180 / .pi - (self?.baselineAngle ?? 0.0)
                let anglePitchInDegrees = data.attitude.pitch * 180 / .pi - (self?.baselineAnglePitch ?? 0.0)
                let angleRollInDegrees = data.attitude.roll * 180 / .pi - (self?.baselineAngleRoll ?? 0.0)
                
                DispatchQueue.main.async {
                    self?.slopeAngle = angleInDegrees
                    self?.slopeAnglePitch = anglePitchInDegrees
                    self?.slopeAngleRoll = angleRollInDegrees
                }
            }
        }
    }
}
