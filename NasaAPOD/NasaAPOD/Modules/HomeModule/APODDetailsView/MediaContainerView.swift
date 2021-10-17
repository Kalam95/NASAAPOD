// Created by mehboob Alam

import UIKit
import AVFoundation


/// A component view to show Media data(image or viedeo)
class MediaContainerView: UIView {
    private lazy var imageView: UIImageView = {
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
    }()

    private lazy var playIcon: UIImageView = {
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
    }()

    
    private(set) lazy var playerLayer: AVPlayerLayer = {
        let layer = AVPlayerLayer()
        layer.frame = self.bounds
        layer.videoGravity = .resizeAspectFill
        self.layer.insertSublayer(layer, at: 0)
        return layer
    }()

    func setupView(mediaType: MediaType?, url: String) {
        self.isHidden = false
        switch mediaType {
        case .image:
            playIcon.isHidden = true
            playerLayer.isHidden = true
            imageView.isHidden = false
            imageView.setImage(from: url)
        case .video:
            setupVideoPreview(url: url)
        default:
            playIcon.isHidden = true
            playerLayer.isHidden = true
            imageView.isHidden = true
        }
    }

    private func setupVideoPreview(url: String) {
        playIcon.isHidden = false
        playerLayer.isHidden = false
        imageView.isHidden = true
        if let url = URL(string: url) {
            playerLayer.player = AVPlayer(url: url)
            playerLayer.player?.isMuted = true
            playerLayer.player?.seek(to: .zero)
            DispatchQueue.main.async {[weak self] in
                self?.playerLayer.frame = self?.bounds ?? .zero
            }
        }
    }
}
