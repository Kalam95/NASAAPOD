//Created by mehboob Alam

import UIKit


/// A progress view with simple UI speciffied in Nib file
class ProgressView: UIView {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        settingsForActivityView()
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        settingsForActivityView()
    }

    func settingsForActivityView() {
        fromNib(type: Self.self)
        containerView.roundedBorders(radius: 20)
        containerView.applyDropShadow(radius: 20) // an expensive and dynamic shadow.
        activityIndicatorView.startAnimating()
    }
}
