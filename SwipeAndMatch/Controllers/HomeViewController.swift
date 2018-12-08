//
//  ViewController.swift
//  SwipeAndMatch
//
//  Created by Admin on 11/10/18.
//  Copyright © 2018 Travelogy. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    let topNavigationStackView = TopNavigationStackView()
    let bottomButtonStackView = HomeBottomControlsStackView()
    let cardDeckView = UIView()
    let users: [User] = [
        User(name: "Jenny", age: 21, proffesion: "Radio Jockey", imageName: "lady5c"),
        User(name: "Kelly", age: 22, proffesion: "Actor", imageName: "lady4c")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
        setupDummyCard()
    }
    
    fileprivate func setupDummyCard(){
//        (0..<10).forEach{(_) in
//            let cardView = CardView(frame: .zero)
//            cardDeckView.addSubview(cardView)
//            cardView.fillSuperview()
//        }
        users.forEach{(user) in
            let cardView = CardView(frame: .zero)
            cardView.imageView.image = UIImage(named: user.imageName)
            let attributedLabel = NSMutableAttributedString(attributedString: NSAttributedString(string: user.name, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)]))
            attributedLabel.append(NSAttributedString(string: " \(user.age)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
            attributedLabel.append(NSAttributedString(string: "\n\(user.proffesion)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
            cardView.informationLabel.attributedText = attributedLabel
            cardDeckView.addSubview(cardView)
            cardView.fillSuperview()
        }
    }
    
    fileprivate func setUpLayout() {
        // Do any additional setup after loading the view, typically from a nib.
        let overallStackView = UIStackView(arrangedSubviews: [topNavigationStackView,cardDeckView,bottomButtonStackView])
        overallStackView.translatesAutoresizingMaskIntoConstraints = false
        overallStackView.axis = .vertical
        view.addSubview(overallStackView)
        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        /**
         *MARK:- StackView internallly assign a 'Z' Index position to all views inside it
         *HERE:- topNavigationStackView has lesser or intial Z index than cardeckview due which cardview comes over the topNavigationStackView
         *But card view is under bottomButtonStackView due to which it gets under the bottomButtonStackView
         *To Overcome the same situation we are brining card deck view above all views using below statement while user moves a card on screen
         *Incase you need to get visual representation Pls comment next line : overallStackView.bringSubviewToFront(cardDeckView)
         */
        overallStackView.bringSubviewToFront(cardDeckView)
    }
}

/*
 *
 *
 fileprivate func returnPropertyMappedViews(colors: [UIColor]) -> Array<UIView> {
 let arrayOfViews = colors.map{ (color) -> UIView in
 let view = UIView()
 view.backgroundColor = color
 return view
 }
 return arrayOfViews
 }
 */

