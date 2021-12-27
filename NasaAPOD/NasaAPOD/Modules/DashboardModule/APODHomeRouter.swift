// Created by mehboob Alam

import UIKit

class APODHomeRouter {

    func startJourney(source: UIWindow) {
        let viewModel = SearchAPODViewModel(apiCleint: APODAPI(networkClient: NetworkClient(baseUrl: AppURL.base.rawValue)))
        let viewConntroller = SearchAPODViewController(viewModel: viewModel, router: APODHomeRouter())
        source.rootViewController = UINavigationController(rootViewController: viewConntroller)
    }

    func showRecentHistoryView( source: UIViewController) {
        let viewModel = AstronomyListViewModel(viewType: .history)
        let vc = AstronomyListViewController(viewModel: viewModel,
                                             router: APODHomeRouter())
        source.navigationController?.pushViewController(vc, animated: true)
    }

    func showFavouritesView(source: UIViewController) {
        let viewModel = AstronomyListViewModel(viewType: .favourites)
        let vc = AstronomyListViewController(viewModel: viewModel,
                                             router: APODHomeRouter())
        source.present(UINavigationController(rootViewController: vc),
                       animated: true, completion: nil)
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

    func showVideo(url: String, source: UIViewController) {
        let viewModel = VideoViewModel(url: url)
        let videoController = VideoPresenterController(detents: [.large(), .medium()],
                                                      viewModel: viewModel)
        source.present(videoController, animated: true, completion: nil)
    }
}
