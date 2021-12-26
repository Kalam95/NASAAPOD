//
//  ViewPresenterController.swift
//  NasaAPOD
//
//  Created by Mehboob Alam on 26.12.21.
//

import YouTubeiOSPlayerHelper
import AVKit

struct VideoViewModel {
    var urlString: String

    var lastPathComponent: String {
        return url?.lastPathComponent ?? ""
    }
    
    init(url: String)  {
        self.urlString = url
    }

    var isYoutube: Bool {
        urlString.contains("youtube")
    }

    var url: URL? {
        URL(string: urlString)
    }
}


class VideoPresenterController: BaseViewController {
    private let viewModel: VideoViewModel
    private let detents: [UISheetPresentationController.Detent]

    init(detents: [UISheetPresentationController.Detent], viewModel: VideoViewModel) {
        self.viewModel = viewModel
        self.detents = detents
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var avPlayer: AVPlayerLayer? = {
        let playerLayer = AVPlayerLayer()
        playerLayer.frame = view.bounds
        playerLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(playerLayer)
        return playerLayer
    }()

    private lazy var youtubePlayerView: YTPlayerView = {
        let playerView = YTPlayerView()
        playerView.frame = view.bounds
        view.addSubview(playerView)
        playerView.translatesAutoresizingMaskIntoConstraints = false
        playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        playerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        playerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        return playerView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        if let sheetController = self.presentationController as? UISheetPresentationController {
            sheetController.detents = detents
            sheetController.preferredCornerRadius = 25
            sheetController.prefersGrabberVisible = true
        }
        view.backgroundColor = .appThemeColor
        viewModel.isYoutube ? playYoutubeVideos() : playVideoUsingAVPLayer()
    }

    private func playVideoUsingAVPLayer() {
        guard let url = viewModel.url, let playerLayer = avPlayer else { return }
        playerLayer.player = AVPlayer(url: url)
        playerLayer.player?.isMuted = false
        playerLayer.player?.seek(to: .zero)
        playerLayer.player?.play()
    }

    private func playYoutubeVideos() {
        youtubePlayerView.load(withVideoId: viewModel.lastPathComponent)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
