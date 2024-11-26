//
//  UIKitImageView.swift
//  DrugCertificationForVisionOS
//
//  Created by 植松優羽 on 2024/11/26.
//
import SwiftUI


struct UIKitImageView: UIViewRepresentable {
    let imageName: String
    
    func makeUIView(context: Context) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit // アスペクト比を維持
        return imageView
    }
    
    func updateUIView(_ uiView: UIImageView, context: Context) {
        if let image = UIImage(named: imageName) {
            uiView.image = image
        } else {
            print("Error: \(imageName) が見つかりません")
        }
    }
}
