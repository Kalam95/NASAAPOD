//
//  APODDetailViewController.swift
//  NasaAPOD
//
//  Created by Mehboob on 16/10/21.
//

import UIKit

class APODDetailViewController: BaseViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mediaView: MediaContainerView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addToFavouritesButton: UIButton!
    
    private let router: APODHomeRouter
    private let viewModel: APODDetailViewModel

    init(viewModel: APODDetailViewModel, router: APODHomeRouter) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        populateData()
        setupUI()
    }

    private func populateData() {
        title = viewModel.date
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.explanation.appending(viewModel.explanation)
        mediaView.setupView(mediaType: viewModel.type ?? .none, url: viewModel.url)
        updateFavouritesButton()
    }

    private func updateFavouritesButton() {
        addToFavouritesButton.setTitle(viewModel.buttonTitle, for: .normal)
        addToFavouritesButton.backgroundColor = viewModel.isFavourite ? .secondaryColor : .white
        addToFavouritesButton.setTitleColor(viewModel.isFavourite ? .white : .appThemeColor,
                                            for: .normal)
    }

    private func setupUI() {
        mediaView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showImagePreview)))
        barTintColor = .white
    }

    @objc private func showImagePreview() {
        ImagePreviewView.showImagePreviewView(images: [viewModel.url])
    }

    @IBAction func addToFavouritesButtonTapped(_ sender: Any) {
        viewModel.updateDatabase() // update data base
        populateData() // update view
    }
}
