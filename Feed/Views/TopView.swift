//
//  TopView.swift
//  Feed
//
//  Created by ברק בן חור on 19/05/2023.
//

import UIKit

protocol TopViewDelegete: AnyObject {
    func didAdd()
    func filter(title: String?, id: String?, userId: String?)
    func filter(geo: String)
}

class TopView: UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var filterButton: UIButton!
    
    @IBOutlet weak var filterView: UIStackView!
    
    @IBOutlet weak var filterViewHight: NSLayoutConstraint!
    
    @IBOutlet weak var titleFilter: UITextField!
    @IBOutlet weak var idFilter: UITextField!
    @IBOutlet weak var userIdFilter: UITextField!
    @IBOutlet weak var byLocation: UIButton!
    
    weak var delegete: TopViewDelegete?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        byLocation.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        byLocation.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .selected)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        Bundle.main.loadNibNamed("TopView", owner: self, options: nil)
        contentView.fixInView(self)
        
        idFilter.keyboardType = .numberPad
        userIdFilter.keyboardType = .numberPad
        
        titleFilter.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        idFilter.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        userIdFilter.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        delegete?.filter(title: titleFilter.text, id: idFilter.text, userId: userIdFilter.text)
    }
    
    @IBAction func byLocation(_ sender: UIButton) {
        guard let loc = LocationManger.sheard.location else { return }
        let geo = "\(loc.coordinate.latitude),\(loc.coordinate.longitude)"
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            delegete?.filter(geo: geo)
        }
        else {
            delegete?.filter(geo: "")
        }
    }
    
    @IBAction func addTap(_ sender: UIButton) {
        delegete?.didAdd()
    }
    
    @IBAction func didFilter(_ sender: UIButton) {
        titleFilter.text = ""
        idFilter.text = ""
        userIdFilter.text = ""
        delegete?.filter(geo: "")
        byLocation.isSelected = false
        filterViewHight.constant = 165.67 - filterViewHight.constant
        delegete?.filter(title: titleFilter.text, id: idFilter.text, userId: userIdFilter.text)
    }
    
    func close() {
        titleFilter.text = ""
        idFilter.text = ""
        userIdFilter.text = ""
        delegete?.filter(geo: "")
        byLocation.isSelected = false
        filterViewHight.constant = 0
    }
}

extension TopView: UITextFieldDelegate { }
