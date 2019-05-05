//
//  TopNavigationStackView.swift
//  SwipeAndMatch
//
//  Created by Admin on 11/11/18.
//  Copyright © 2018 Travelogy. All rights reserved.
//

import UIKit

class TopNavigationStackView: UIStackView {
    let settingButton = UIButton(type: .system)
    let messageButton = UIButton(type: .system)
    let fireIcon = UIImageView(image: #imageLiteral(resourceName: "app_icon"))

    override init(frame: CGRect) {
        super.init(frame: frame)
        fireIcon.contentMode = .scaleAspectFit
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        distribution = .equalCentering
        heightAnchor.constraint(equalToConstant: 70).isActive = true
        translatesAutoresizingMaskIntoConstraints = false

        settingButton.setImage(#imageLiteral(resourceName: "top_left_profile").withRenderingMode(.alwaysOriginal), for: .normal)
        messageButton.setImage(#imageLiteral(resourceName: "top_right_messages").withRenderingMode(.alwaysOriginal), for: .normal)
        
        [settingButton,UIView(),fireIcon,UIView(),messageButton].forEach{(view) in
            addArrangedSubview(view)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
