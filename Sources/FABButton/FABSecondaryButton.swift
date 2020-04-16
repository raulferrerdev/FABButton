//  Copyright (c) 2020 Raúl Ferrer
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
//  DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
//  OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
//  OR OTHER DEALINGS IN THE SOFTWARE.
//
//
//  Created by RaulF on 10/04/2020.
//

import UIKit

public protocol FABSecondaryButtonDelegate: class {
    func secondaryActionForButton(_ action: @escaping () -> ())
}

//public typealias FABSecondaryAction = () -> ()

typealias FABSecondary = (title: String, image: UIImage, action: () -> ())

class FABSecondaryButton: UIView {
    
    private var secondaryButton = UIButton(frame: .zero)
    private var buttonLabel = FABInsetLabel(frame: .zero)
    private var labelView = UIView(frame: .zero)
    private var fabSecondary: FABSecondary!
    
    weak var delegate: FABSecondaryButtonDelegate?

    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }

    init(fabSecondary: FABSecondary) {
         super.init(frame: .zero)
         self.fabSecondary = fabSecondary
         configure()
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        configureSecondaryButton()
        configureLabel()
        configureLayoutUI()
    }
    
    
    private func configureSecondaryButton() {
        secondaryButton.translatesAutoresizingMaskIntoConstraints = false
        secondaryButton.setImage(fabSecondary.image, for: .normal)
        secondaryButton.backgroundColor = UIColor.white
        secondaryButton.layer.cornerRadius = 17
        secondaryButton.addTarget(self, action: #selector(secondaryButtonAction), for: .touchUpInside)
        
        dropShadowToView(secondaryButton)
    }
    
    
    @objc private func secondaryButtonAction() {
        delegate?.secondaryActionForButton(fabSecondary.action)
    }
    
    
    private func configureLabel() {
        labelView.backgroundColor = .white
        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.layer.cornerRadius = 4
        dropShadowToView(labelView)
        
        buttonLabel.translatesAutoresizingMaskIntoConstraints = false
        buttonLabel.font = .systemFont(ofSize: 11)
        buttonLabel.textAlignment = .center
        buttonLabel.text = fabSecondary.title
        buttonLabel.textColor = .gray
        buttonLabel.contentInsets = UIEdgeInsets(top: 0, left: 7, bottom: 0, right: 7)
    }

    
    private func configureLayoutUI() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(labelView)
        labelView.addSubview(buttonLabel)
        addSubview(secondaryButton)
        
        NSLayoutConstraint.activate([
            secondaryButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            secondaryButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -9),
            secondaryButton.widthAnchor.constraint(equalToConstant: 34),
            secondaryButton.heightAnchor.constraint(equalToConstant: 34),
            
            labelView.centerYAnchor.constraint(equalTo: centerYAnchor),
            labelView.leadingAnchor.constraint(equalTo: buttonLabel.leadingAnchor),
            labelView.trailingAnchor.constraint(equalTo: secondaryButton.leadingAnchor, constant: -12),
            labelView.heightAnchor.constraint(equalToConstant: 27),
            
            buttonLabel.trailingAnchor.constraint(equalTo: labelView.trailingAnchor),
            buttonLabel.topAnchor.constraint(equalTo: labelView.topAnchor),
            buttonLabel.bottomAnchor.constraint(equalTo: labelView.bottomAnchor),
        ])
    }
    
    
    private func dropShadowToView(_ view: UIView) {
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        view.layer.shadowRadius = 4.0
        view.layer.shadowOpacity = 0.4
    }
}

