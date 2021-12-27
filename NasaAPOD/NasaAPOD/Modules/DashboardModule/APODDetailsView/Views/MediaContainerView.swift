// Created by mehboob Alam

import UIKit
import AVFoundation


/// A component view to show Media data(image or viedeo)
class MediaContainerView: UIView {
    private weak var imageView: UIImageView?
    private weak var playIcon: UIImageView?
//  private(set) weak var playerLayer: AVPlayerLayer?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        imageView = getMediaImageView()
        playIcon = getPlaiIconImage()
    }
    func setupView(mediaType: MediaType?, url: String) {
        imageView?.image = UIImage(named: "placeholder")
        self.isHidden = false
        switch mediaType {
        case .image:
            playIcon?.isHidden = true
            imageView?.isHidden = false
            imageView?.setImage(from: url)
        case .video:
            playIcon?.isHidden = false
            imageView?.setImage(from: url)
        default:
            playIcon?.isHidden = true
        }
    }

    private func getPlayerLayer() -> AVPlayerLayer {
        let layer = AVPlayerLayer()
        layer.frame = self.bounds
        layer.videoGravity = .resizeAspectFill
        self.layer.insertSublayer(layer, at: 0)
        return layer
    }

    private func getPlaiIconImage() -> UIImageView {
        let image = UIImageView(image: UIImage(named: "playIcon"))
        image.contentMode = .scaleAspectFit
        addSubview(image)
        image.backgroundColor = .lightText
        image.translatesAutoresizingMaskIntoConstraints = false
        image.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        image.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        image.heightAnchor.constraint(equalToConstant: 40).isActive = true
        image.widthAnchor.constraint(equalToConstant: 40).isActive = true
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        return image
    }

    private func getMediaImageView() -> UIImageView {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        addSubview(image)
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        image.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        image.topAnchor.constraint(equalTo: topAnchor).isActive = true
        image.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        return image
    }

//    private func setupVideoPreview(url: String) {
//        playIcon.isHidden = false
//        playerLayer.isHidden = false
//        imageView.isHidden = true
//         in case we wann preview the videos on cell or detail screen only
//        if let url = URL(string: url) {
//            playerLayer.player = AVPlayer(url: url)
//            playerLayer.player?.isMuted = true
//            playerLayer.player?.seek(to: .zero)
//            DispatchQueue.main.async {[weak self] in
//                self?.playerLayer.frame = self?.bounds ?? .zero
//            }
//        }
//    }
}
