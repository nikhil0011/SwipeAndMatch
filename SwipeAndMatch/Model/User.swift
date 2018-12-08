//
//  User.swift
//  SwipeAndMatch
//
//  Created by Admin on 11/18/18.
//  Copyright © 2018 Travelogy. All rights reserved.
//

import UIKit

struct User: ProduceCardViewModel {
    let name: String
    let age: Int
    let proffesion: String
    let imageName: String
    
    func toCardViewModel() -> CardViewModel{
        let attributedLabel = NSMutableAttributedString(attributedString: NSAttributedString(string: name, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)]))
        attributedLabel.append(NSAttributedString(string: " \(age)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
        attributedLabel.append(NSAttributedString(string: "\n\(proffesion)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
        let viewModel = CardViewModel(imageName: imageName, attributedText: attributedLabel, textAlignment: .left)
        return viewModel
    }
}
//469
//20720
//21007
