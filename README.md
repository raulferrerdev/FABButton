# FABButton

**FABButton** allows you to add a button that when pressed shows a menu in the form of secondary buttons.

### Installation
As FABButton is a SPM (Swift Package Manager) component, should be added from the menu File > Swift Packages > Add Package Dependency...

![image](https://drive.google.com/uc?export=view&id=1Qu-T5O7wTQ_w1i__Ai9MeLEwlCqYv6Q-)

![image](https://drive.google.com/uc?export=view&id=1xNEtkaJNeO8DlL4KVw2EdIg0Q1Zf-yEu)

Then we can add in a UIViewController as follows:

```Swift
import UIKit
import FABButton

class ViewController: UIViewController {

    // Create main container, with the main button image
    private let container = FABView(buttonImage: UIImage(named: "shared"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Set FABButton delegate
        container.delegate = self

        // Add secondary buttons
        container.addSecondaryButtonWith(image: UIImage(named: "twitter")!, labelTitle: "Twitter", action: {
            print("Twitter")
        })
        container.addSecondaryButtonWith(image: UIImage(named: "linkedin")!, labelTitle: "Linkedin", action: {
            print("Linkedin")
        })
        container.addSecondaryButtonWith(image: UIImage(named: "instagram")!, labelTitle: "Instagram", action: {
            print("Instagram")
        })
        container.addSecondaryButtonWith(image: UIImage(named: "facebook")!, labelTitle: "Facebook", action: {
            print("Facebook")
        })
        container.setFABButton()
    }
    

    private func configure() {
        view.backgroundColor = .white
        view.addSubview(container)
        NSLayoutConstraint.activate([
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            container.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
}

// Add FABSecondaryButtonDelegate delegate methods
extension ViewController: FABSecondaryButtonDelegate {
    func secondaryActionForButton(_ action: FABSecondaryAction) {
        action()
    }
}
```

![image](https://drive.google.com/uc?export=view&id=1XqpcNJQs-250OgeVy_IQWN383hD_CQVJ)