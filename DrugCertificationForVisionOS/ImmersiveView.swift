//
//  ImmersiveView.swift
//  DrugCertificationForVisionOS
//
//  Created by 植松優羽 on 2024/11/06.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {

    var body: some View {
        RealityView { content in
            // Add the initial RealityKit content
            if let immersiveContentEntity = try? await Entity(named: "Immersive", in: realityKitContentBundle) {
                content.add(immersiveContentEntity)

                // Put skybox here.  See example in World project available at
                // https://developer.apple.com/
            }
        }
    }
}

#Preview(immersionStyle: .mixed) {
    ImmersiveView()
        .environment(AppModel())
}