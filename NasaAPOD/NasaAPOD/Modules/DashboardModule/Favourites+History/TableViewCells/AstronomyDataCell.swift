// Created by mehboob Alam

import UIKit

class AstronomyDataCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var mediaView: MediaContainerView!
    @IBOutlet weak var imagViewHeight: NSLayoutConstraint!
    @IBOutlet weak var subtTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        imagViewHeight?.constant = .minRelative(size: 200)
        containerView.roundedBorders(radius: .minRelative(size: 10),
                                     borderColor: .secondaryColor,
                                     borderWidth: 1)
    }

    func populateCell(with data: APODDataModel?) {
        guard let data = data else {
            return
        }
        dateLabel.text = data.date?.getString(format: .dd_MMM_yyyy)
        mediaView.setupView(mediaType: data.mediaType ?? .image,
                            url: data.imageURL ?? "")
        nameLabel.text = data.title ?? "N/A"
        subtTitleLabel.text = data.explanation
    }
}

