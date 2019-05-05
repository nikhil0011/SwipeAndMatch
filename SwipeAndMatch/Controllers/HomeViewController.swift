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
//    let users: [User] = [
//        User(name: "Jenny", age: 21, proffesion: "Radio Jockey", imageName: "lady5c"),
//        User(name: "Kelly", age: 22, proffesion: "Actor", imageName: "lady4c")
//    ]
    
    let cardViewModel: [CardViewModel] = {
        let producer = [
            User(name: "Jenny", age: 21, proffesion: "Radio Jockey", imageNames: ["jane1","jane2","jane3"]),
            User(name: "Kelly", age: 22, proffesion: "Actor", imageNames: ["kelly1","kelly2","kelly3"]),
            Advertiser(title: "Slide Out Menu", brandName: "Travelogy", posterName: "slide_out_menu_poster")
            ] as [ProduceCardViewModel]
        let viewModels = producer.map({return $0.toCardViewModel()})
        return viewModels
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
        setupDummyCard()
    }
    
    fileprivate func setupDummyCard(){
//        (0..<10).forEach{(_) in
//        }        
        cardViewModel.forEach{(cardVM) in
            let cardView = CardView(frame: .zero)
            cardView.cardViewModel = cardVM
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

