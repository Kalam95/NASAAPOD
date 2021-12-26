//Created by mehboob Alam

import UIKit


/// Button for seconday[Outlined] actiosn handling, its is a bordered button with colored text
/// properties are self descriptive
public class SecondaryButton: UIButton {

    public var title: String? {
        didSet {
            self.setTitle(title, for: .normal) 
        }
    }

    public var showBorder: Bool = false {
        didSet {
            if showBorder {
                layer.borderWidth = 1
                layer.borderColor = UIColor.white.cgColor
            }
        }
    }

    public var titleColor: UIColor? {
        didSet {
            setTitleColor(titleColor, for: .normal)
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
        clipsToBounds = true
        layer.cornerRadius = 10
        titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        backgroundColor = .clear
        showBorder = true
    }

    public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        setTitleColor(.white, for: .normal)
        setTitleColor(.lightText, for: .disabled)
    }

    override public func layoutSubviews() {
        let identifier = (self.title?.localizedLowercase ?? "")
        self.accessibilityIdentifier = "\(identifier) button"
        super.layoutSubviews()
    }
}

