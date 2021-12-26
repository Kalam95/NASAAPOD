// Created by mehboob Alam

import UIKit
import AVKit
import WebKit

class SearchAPODViewController: BaseViewController {

    @IBOutlet weak var dateTextField: DateTextField!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var searchButton: PrimarySolidButton!
    @IBOutlet weak var viewHistoryButton: SecondaryButton!
    @IBOutlet weak var last50APODButton: PrimarySolidButton!
    
    let viewModel: SearchAPODViewModel
    let router: APODHomeRouter
    
    init(viewModel: SearchAPODViewModel, router: APODHomeRouter) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsAtViewDidLoad()
    }

    override func rightBarButtonPressed() {
        router.showFavouritesView(source: self)
    }

    private func settingsAtViewDidLoad() {
        setupUI()
        bindViewModel()
    }

    private func bindViewModel() {
        dateTextField.value.subscribe(onNext:  { [weak self] _ in
            self?.searchButton.isEnabled = true
        })

        viewModel.signal.subscribe { [weak self] _ in
            guard let self = self, let data = self.viewModel.getData() else { return }
            self.hideLoader()
            self.router.showDetailView(data: data, source: self)
        } onError: { [weak self] error in
            self?.hideLoader()
            self?.showAlert(title: "Failure!!", description: error.errorMessage, primaryAction: ("OK", {[weak self] in
                self?.navigationController?.popViewController(animated: true)
            }))
        }
    }

    private func setupUI() {
        dateTextField.maximumDate = Date()
        searchButton.isEnabled = false
        title = "APOD"
        addRightButtion(title: "Favourties")
        last50APODButton.isEnabled = true
    }

    @IBAction func searchButtonTapped(_ sender: Any) {
        guard let date = dateTextField.date else { return }
        dateTextField.resignFirstResponder()
        showLoader()
        viewModel.sendRequest(date: date)
    }
    
    @IBAction func viewHistoryButtonTapped(_ sender: Any) {
        router.showRecentHistoryView(source: self)
    }

    @IBAction func last50APODButtonTapped(_ sender: Any) {
        router.showLast50DaysView(source: self)
    }
    
}
