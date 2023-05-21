//
//  TextView.swift
//  Feed
//
//  Created by ברק בן חור on 20/05/2023.
//

import UIKit

class TextView: UIView {
    private let textView = UITextView()
    private let placeHolder = UILabel()
    
    var text: String { get { return textView.text } }
    
    var placeHolderText: String = "" {
        didSet {
            placeHolder.text = placeHolderText
        }
    }
    
    var isBold: Bool = false {
        didSet {
            if isBold {
                textView.font = .boldSystemFont(ofSize: 14)
            }
            else {
                textView.font = .systemFont(ofSize: 14)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textView.font = .systemFont(ofSize: 14)
        
        addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([textView.topAnchor.constraint(equalTo: topAnchor),
                                     textView.bottomAnchor.constraint(equalTo: bottomAnchor),
                                     textView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     textView.trailingAnchor.constraint(equalTo: trailingAnchor)])
        
        
        placeHolder.textAlignment = .center
        addSubview(placeHolder)
        placeHolder.textColor = .systemGray4
        placeHolder.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([placeHolder.topAnchor.constraint(equalTo: topAnchor, constant: 10),
                                     placeHolder.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -10),
                                     placeHolder.leadingAnchor.constraint(equalTo: leadingAnchor, constant:  20),
                                     placeHolder.trailingAnchor.constraint(equalTo: trailingAnchor, constant:  -20)])
        
        textView.delegate = self
    }
}

extension TextView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) { //Handle the text changes here
        placeHolder.isHidden = !textView.text.isEmpty
    }
}
