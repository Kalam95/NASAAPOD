//
//  DateTextField.swift
//
//  Created by Mehboob Alam
//
import UIKit

class DateTextField: UITextField {
    private var datePicker = UIDatePicker()
    var dateType: UIDatePicker.Mode = .date
    var pickerStye: UIDatePickerStyle = .inline
    var dateFormate: DateFormat = .dd_MMM_yyyy
    let value: PublishSubject<Date?> = {PublishSubject()}()
    var isClearButtonVisisble: Bool = false
    var date: Date? {
        text?.isEmpty != false ? nil : datePicker.date
    }
    var maximumDate: Date? {
        willSet {
            datePicker.maximumDate = newValue
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSettings()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSettings()
    }

    var minimumDate: Date? {
        didSet {
            datePicker.minimumDate = minimumDate
        }
    }

    var plaeholderText: String = "Select a date" {
        didSet {
            setPlaholderText()
        }
    }

    private func initialSettings() {
        delegate = self
        backgroundColor = .white
        tintColor = .appThemeColor
        textColor = .appThemeColor
        datePicker.locale = .current
        datePicker.tintColor = .appThemeColor
        datePicker.backgroundColor = .white
        datePicker.addTarget(self, action: #selector(dateDidChange), for: .valueChanged)
        setPlaholderText()
    }

    private func setPlaholderText() {
        placeholder = plaeholderText
        if traitCollection.userInterfaceStyle == .dark {
            attributedPlaceholder = NSAttributedString(string: plaeholderText,
                                                       attributes: [.font: UIFont.systemFont(ofSize: 14),
                                                                    .foregroundColor: UIColor.gray])
        }
    }

    @objc private func dateDidChange(_ sender: UIDatePicker?) {
        setDate()
    }
    
    @objc  private func doneButtonTapped(_ sender: Any?) {
        resignFirstResponder()
    }

    @objc private func clearButtonTapped(_ sender: Any?) {
        text = nil
        datePicker.date = minimumDate ?? Date()
        value.onNext(nil)
    }
    
    fileprivate func setupDatePicker(){
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        var buttonSet = [UIBarButtonItem]()
        if isClearButtonVisisble {
            buttonSet.append(UIBarButtonItem(title: "Clear",
                                                         style: .plain,
                                                         target: self,
                                                         action: #selector(clearButtonTapped(_:))))
        }
        buttonSet.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                         target: nil,
                                         action: nil))
        buttonSet.append( UIBarButtonItem(title: "Done",
                                          style: .plain,
                                          target: self,
                                          action: #selector(doneButtonTapped(_:))))
        toolbar.setItems(buttonSet, animated: false)
        toolbar.tintColor = .appThemeColor
        datePicker.preferredDatePickerStyle = pickerStye
        datePicker.datePickerMode = dateType
        inputAccessoryView = toolbar
        inputView = datePicker
    }
    
    private func setDate() {
        // check if mimimum date is greater than the date user entered or selected
        if let minimumDate = minimumDate, minimumDate.timeIntervalSince(datePicker.date) <= 24*60*60 {
            datePicker.date = minimumDate
        }
        switch dateType {
        case .date, .dateAndTime:
            text = datePicker.date.getString(format:  dateFormate)
        case .countDownTimer, .time:
            text = datePicker.date.getString(format:  .hhmm_a)
        @unknown default:
            fatalError("Type Unknown")
        }
        value.onNext(datePicker.date)
    }

    
    /// set specific date if required
    /// - Parameters:
    ///   - dateString: date in string
    ///   - format: format of the date string
    func setDate(dateString: String?, format: DateFormat) {
        let date = dateString?.getDate(format: format)
        text = dateString?.changeDateFormat(fromFromat: format, toFormat: self.dateFormate)
        datePicker.setDate(date ?? Date(), animated: true)
    }
}

extension  DateTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        setupDatePicker()
        setDate()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // not allowing user to paste or enteranything in the field
        return false
     }
}
