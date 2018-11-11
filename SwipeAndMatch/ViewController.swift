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
    let blueView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blueView.backgroundColor = .white
        setUpLayout()
    }
    
    fileprivate func setUpLayout() {
        // Do any additional setup after loading the view, typically from a nib.
        let overallStackView = UIStackView(arrangedSubviews: [topNavigationStackView,blueView,bottomButtonStackView])
        overallStackView.translatesAutoresizingMaskIntoConstraints = false
        overallStackView.axis = .vertical
        view.addSubview(overallStackView)
        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
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

