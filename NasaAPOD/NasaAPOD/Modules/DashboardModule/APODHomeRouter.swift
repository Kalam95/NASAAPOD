// Created by mehboob Alam

import Foundation
import AVKit

class APODHomeRouter {

    func showVideo(data: APODDataModel, source: UIViewController) {
        guard let url = URL(string: data.url ?? "") else { return }
        let controller = AVPlayerViewController()
        controller.videoGravity = .resizeAspect
        controller.player = AVPlayer(url: url)
        controller.player?.isMuted = false
        source.present(controller, animated: true, completion: {[weak controller] in
            controller?.player?.play()
        })
    }

    func showRecentHistoryView( source: UIViewController) {
        let viewModel = AstronomyListViewModel(viewType: .history)
        let vc = AstronomyListViewController(viewModel: viewModel,
                                             router: APODHomeRouter())
        source.navigationController?.pushViewController(vc, animated: true)
    }

    func showFavouritesView(source: UIViewController) {
        let viewModel = AstronomyListViewModel(viewType: .favourites)
        let vc = AstronomyListViewController(detents: [.large()],
                                             viewModel: viewModel,
                                             router: APODHomeRouter())
        source.present(UINavigationController(rootViewController: vc),
                       animated: true, completion: nil)
    }

    func startJourney(source: UIWindow) {
        let viewModel = SearchAPODViewModel(apiCleint: APODAPI(networkClient: NetworkClient(baseUrl: AppURL.base.rawValue)))
        let viewConntroller = SearchAPODViewController(viewModel: viewModel, router: APODHomeRouter())
        source.rootViewController = UINavigationController(rootViewController: viewConntroller)
        
    }

    func showDetailView(data: APODDataModel, source: UIViewController) {
        let viewModel = APODDetailViewModel(data: data)
        let viewController = APODDetailViewController(viewModel: viewModel,
                                                      router: APODHomeRouter())
        source.navigationController?.pushViewController(viewController,
                                                        animated: true)
    }

    func showLast50DaysView(source: UIViewController) {
        let apiClient = APODAPI(networkClient: NetworkClient(baseUrl: AppURL.base.rawValue))
        let viewModel = Last50DaysViewModel(apiClient: apiClient)
        let viewController = Last50DaysViewController(viewModel: viewModel,
                                                      router: APODHomeRouter())
        source.navigationController?.pushViewController(viewController,
                                                        animated: true)
    }
}
