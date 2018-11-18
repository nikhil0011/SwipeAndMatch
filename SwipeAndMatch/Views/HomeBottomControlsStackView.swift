//
//  HomeBottomControlsStackView.swift
//  SwipeAndMatch
//
//  Created by Admin on 11/10/18.
//  Copyright © 2018 Travelogy. All rights reserved.
//

import UIKit

class HomeBottomControlsStackView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        distribution = .fillEqually
        heightAnchor.constraint(equalToConstant: 90).isActive = true

        let buttonImagesArray: Array<UIImage> = [#imageLiteral(resourceName: "refresh_circle"),#imageLiteral(resourceName: "dismiss_circle"),#imageLiteral(resourceName: "super_like_circle"),#imageLiteral(resourceName: "like_circle"),#imageLiteral(resourceName: "boost_circle")]
        let buttonArray = buttonImagesArray.map{(image) -> UIView in
            let button = UIButton(type: .system)
            button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
            return button
        }
        
        buttonArray.forEach{(view) in
            addArrangedSubview(view)
        }
        
        //        let colorsArray: Array<UIColor> = [UIColor.purple,.yellow, .green, .blue, .lightGray]
        //        let subviews = returnPropertyMappedViews(colors: colorsArray)
    }

    required init(coder: NSCoder) {
        fatalError("Init Decoder has not been implemented")
    }
    fileprivate func returnPropertyMappedViews(colors: [UIColor]) -> Array<UIView> {
        let arrayOfViews = colors.map{ (color) -> UIView in
            let view = UIView()
            view.backgroundColor = color
            return view
        }
        return arrayOfViews
    }
}
