//
//  Last50DaysViewController.swift
//  NasaAPOD
//
//  Created by Mehboob Alam on 25.12.21.
//

import UIKit

class Last50DaysViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBarView: SearbarView!
    
    let viewModel: Last50DaysViewModel
    let router: APODHomeRouter
    
    init(viewModel: Last50DaysViewModel, router: APODHomeRouter) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
        setupUIView()
        showLoader()
        viewModel.sendRequestForLast50Images()
    }

    private func bindView() {
        viewModel.signal.subscribe(onNext: {[weak self] _ in
            self?.hideLoader()
            self?.updateView()
        }, onError: { [weak self] error in
            self?.hideLoader()
            self?.showAlert(title: "Failure!!",
                            description: error.errorMessage,
                            primaryAction: ("OK", {[weak self] in
                self?.navigationController?.popViewController(animated: true)
            }))
        })
        searchBarView.date.subscribe(onNext: {[weak self] date in
            self?.viewModel.filter(forDate: date)
            self?.updateView()
        })
    }

    private func setupUIView() {
        title = "Last 50 APODs"
        searchBarView.isClearButtonVisisble = true
        barTintColor = .white
        tableView.registerCell(type: AstronomyDataCell.self)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
    }

    private func updateView() {
        tableView.reloadData()
        tableView.backgroundView =  viewModel.numberOfRows > 0  ? nil : getPlaceholderView()
    }

    private func getPlaceholderView() -> UIView {
        let label = UILabel()
        label.textColor = .appThemeColor
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "No data found"// any random message
        return label
    }
}

extension Last50DaysViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AstronomyDataCell = tableView.dequeueTypedCell(for: indexPath)
        cell.populateCell(with: viewModel.getItem(at: indexPath.row))
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let data = viewModel.getItem(at: indexPath.row) else { return }
        router.showDetailView(data: data, source: self)
    }
}
