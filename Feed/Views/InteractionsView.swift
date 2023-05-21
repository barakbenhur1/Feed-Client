//
//  EditView.swift
//  Feed
//
//  Created by ברק בן חור on 21/05/2023.
//

import UIKit
import MapKit

protocol InteractionsViewDelegate: AnyObject {
    func back()
    func remove()
    func update()
    func shere()
    func map()
}

class InteractionsView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var shere: UIButton!
    @IBOutlet weak var map: UIButton!
    
    weak var delegate: InteractionsViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
 
    func commonInit() {
        Bundle.main.loadNibNamed("InteractionsView", owner: self, options: nil)
        contentView.fixInView(self)
    }
    
    @IBAction func back(_ sender: UIButton) {
        delegate?.back()
    }
    
    @IBAction func remove(_ sender: UIButton) {
        delegate?.remove()
    }
    
    @IBAction func update(_ sender: UIButton) {
        delegate?.update()
    }
    
    @IBAction func shere(_ sender: UIButton) {
        delegate?.shere()
    }
    
    @IBAction func map(_ sender: UIButton) {
        delegate?.map()
    }
}
