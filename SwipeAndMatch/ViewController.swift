//
//  ViewController.swift
//  SwipeAndMatch
//
//  Created by Admin on 11/10/18.
//  Copyright © 2018 Travelogy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let topNavigationStackView = TopNavigationStackView()
    let bottomButtonStackView = HomeBottomControlsStackView()
    let cardDeckView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
        setupDummyCard()
    }
    
    fileprivate func setupDummyCard(){
        let cardView = CardView(frame: .zero)
        cardDeckView.addSubview(cardView)
        cardView.fillSuperview()
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

