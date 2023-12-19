//
//  ContentView.swift
//  slopemeter
//
//  Created by Andrii Iliukhin on 12/13/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = SlopeViewModel()
    var body: some View {
        VStack {
                    Text("Pitch Angle: \(viewModel.slopeAnglePitch, specifier: "%.2f")°")
                        .font(.title)
                    Text("Roll Angle: \(viewModel.slopeAngleRoll, specifier: "%.2f")°")
                        .font(.title)
                    

                    Button(action: {
                        viewModel.calibrate()
                    }) {
                        Text("Calibrate")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                .padding()
    }
}

#Preview {
    ContentView()
        .padding()
}
