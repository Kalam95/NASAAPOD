//
//  SearbarView.swift
//  NasaAPOD
//
//  Created by Mehboob Alam on 26.12.21.
//

import UIKit

/// Simple Header View for search field
public class SearbarView: UIView {

    @IBOutlet weak var dateField: DateTextField!
    @IBOutlet private weak var infoLabel: UILabel!

    var isClearButtonVisisble: Bool {
        get {
            dateField.isClearButtonVisisble
        }
        set {
            dateField.isClearButtonVisisble = newValue
        }
    }


    public var infoText: String? {
        willSet {
            infoLabel.text = newValue
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        fromNib(type: Self.self)
    }
}
