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
    
    func sizeThatFits(in size: CGSize) -> CGSize? {
        return size // 使用するサイズを返す
    }
}
