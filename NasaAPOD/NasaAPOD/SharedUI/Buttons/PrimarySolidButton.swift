//Created by mehboob Alam

import UIKit
/// Button for seconday[Outlined] actiosn handling, its is a bordered button with colored text
/// properties are self descriptive
public class PrimarySolidButton: UIButton {

    public var title: String? {
        didSet {
            self.setTitle(title, for: .normal)
        }
    }

    public override var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ? .white : .lightText
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    private func commonInit() {
        layer.cornerRadius = 10
        clipsToBounds = true
        setTitleColor(.appThemeColor, for: .normal)
        backgroundColor = UIColor.white
        titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        applyDropShadow(radius: 10)
    }
}
