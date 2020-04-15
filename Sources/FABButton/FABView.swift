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

public class FABView: UIStackView {
    
    private let stackView = FABStackView(frame: .zero)
    private var mainButton = FABMainButton(frame: .zero)
    private var isMenuOnScreen: Bool = false
    
    weak public var delegate: FABSecondaryButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    
    public init(buttonImage: UIImage?) {
        super.init(frame: .zero)
        
        mainButton.setImage(buttonImage, for: .normal)
        mainButton.addTarget(self, action: #selector(mainButtonAction), for: .touchUpInside)
        configure()
    }
    
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        configureContainer()
        layoutUI()
    }
    
    
    private func configureContainer() {
        translatesAutoresizingMaskIntoConstraints = false
        distribution = .fill
        axis = .vertical
        alignment = .trailing
        spacing = 16
        clipsToBounds = true
        stackView.delegate = self
    }
    

    @objc private func mainButtonAction() {
        isMenuOnScreen ? stackView.dismissButtons() : stackView.showButtons()
        isMenuOnScreen.toggle()
    }
    
    
    private func layoutUI() {
        addArrangedSubview(stackView)
        addArrangedSubview(mainButton)

        NSLayoutConstraint.activate([
            mainButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainButton.widthAnchor.constraint(equalToConstant: 50),
            mainButton.heightAnchor.constraint(equalToConstant: 50),
            
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
//            stackView.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
}

public extension FABView {
    func addSecondaryButtonWith(image: UIImage, labelTitle: String, action: @escaping () -> ()) {
        stackView.addSecondaryButtonWith(image: image, labelTitle: labelTitle, action: action)
    }
    
    
    func setFABButton() {
        stackView.setFABButton()
    }
    
    
    func resetFABButton() {
        stackView.resetFABButton()
    }
}


extension FABView: FABSecondaryButtonDelegate {
    public func secondaryActionForButton(_ action: FABSecondaryAction) {
        isMenuOnScreen.toggle()
        delegate?.secondaryActionForButton(action)
    }
}
