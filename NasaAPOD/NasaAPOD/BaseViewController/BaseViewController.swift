//Created by mehboob Alam

import UIKit


/// BaseViewContrroller, which contains code related to all the view controllers,
/// such as common navigation bar settings, or showing and hiding alerts
class BaseViewController: UIViewController { 

    
    /// Varible to update bar tint color
    var barTintColor: UIColor? {
        willSet {
            navigationController?.navigationBar.tintColor = newValue
        }
    }

    var titleColor: UIColor = .white {
        willSet {
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: newValue,
                                                                       .font: titleFont]
        }
    }

    var titleFont: UIFont = .systemFont(ofSize: 17, weight: .bold) {
        willSet {
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: titleColor,
                                                                       .font: newValue]
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        titleColor = .white
    }

    
    /// Method to show curtaom alert
    /// - Parameters:
    ///   - title: title for the alert
    ///   - description: description or message for the alert
    ///   - attributedDescription: attributed description or message for the alert
    ///   - primaryAction: Main action
    ///   - secondaryAction: optional action button
    func showAlert(title: String, description: String, attributedDescription: NSAttributedString? = nil, primaryAction: PrimaryAlertView.Action, secondaryAction: PrimaryAlertView.Action? = nil) {
        let alert = PrimaryAlertView(frame: self.view.window?.frame ?? self.view.frame)
        alert.configure(title: title, description: description, attributedDescription: attributedDescription,
                        primaryAction: primaryAction, secondaryAction: secondaryAction)
        self.addToViewWindow(subView: alert)
    }

    private func addToViewWindow(subView: UIView) {
        view.window?.addSubview(subView)
    }

    func showLoader() {
        let progressView = ProgressView(frame: UIScreen.main.bounds)
        self.view.addSubview(progressView)
    }

    func hideLoader() {
        view.subviews.last(where: {$0 is ProgressView})?.removeFromSuperview()
    }

    
    /// Method to add right bar button on view
    /// - Parameter title: name of the button
    func addRightButtion(title: String) {
        let rightBarButton = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(rightBarButtonPressed))
        rightBarButton.tintColor = .white
        navigationItem.rightBarButtonItem = rightBarButton
    }

    @objc func rightBarButtonPressed() {
        // override to write
    }

    func getColoredNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .appThemeColor
        appearance.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 20.0),
                                          .foregroundColor: UIColor.white]

        // Customizing our navigation bar
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}
