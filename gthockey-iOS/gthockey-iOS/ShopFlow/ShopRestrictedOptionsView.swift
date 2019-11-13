//
//  ShopRestrictedOptionsView.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 11/8/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

class ShopRestrictedOptionsView: UIView, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    // MARK: Properties

    private var selectionList: [String]?

    private let displayLabel: UILabel = {
        let displayLabel = UILabel()
        displayLabel.font = UIFont(name:"HelveticaNeue", size: 24.0)
        displayLabel.text = "Size"
        displayLabel.adjustsFontSizeToFitWidth = true
        displayLabel.numberOfLines = 1
        displayLabel.textAlignment = .left
        displayLabel.translatesAutoresizingMaskIntoConstraints = false
        return displayLabel
    }()

    private let optionsTextField: UITextField = {
        let optionsTextField = UITextField()
        optionsTextField.backgroundColor = .white
        optionsTextField.textColor = .black
//        optionsTextField.placeholder = ""
        optionsTextField.font = UIFont(name:"HelveticaNeue-Light", size: 24.0)
        optionsTextField.translatesAutoresizingMaskIntoConstraints = false
        return optionsTextField
    }()

    let optionsPickerView: UIPickerView = {
        let optionsPickerView = UIPickerView()
        optionsPickerView.translatesAutoresizingMaskIntoConstraints = false
        return optionsPickerView
    }()

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        translatesAutoresizingMaskIntoConstraints = false

        optionsPickerView.delegate = self
        optionsPickerView.dataSource = self

        let toolBar = UIToolbar()
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePicker))
        toolBar.setItems([doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true

        optionsTextField.delegate = self
        optionsTextField.inputView = optionsPickerView
        optionsTextField.inputAccessoryView = toolBar

        addSubviews([displayLabel, optionsTextField])

        updateConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        super.updateConstraints()

        NSLayoutConstraint.activate([
            displayLabel.topAnchor.constraint(equalTo: topAnchor),
            displayLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            displayLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            optionsTextField.topAnchor.constraint(equalTo: displayLabel.bottomAnchor, constant: 8.0),
            optionsTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            optionsTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            optionsTextField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    // MARK: __________

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return selectionList?.count ?? 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return selectionList?[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        optionsTextField.text = selectionList?[row]
    }

    @objc func donePicker() {
        endEditing(true)
    }

    // MARK: Setter

    public func set(with restrictedItem: ApparelRestrictedItem) {
        displayLabel.text = restrictedItem.getDisplayName()
        optionsTextField.placeholder = "Size"
        selectionList = restrictedItem.getOptionsList()
    }

}

