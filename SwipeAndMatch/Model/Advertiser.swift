//
//  Advertiser.swift
//  SwipeAndMatch
//
//  Created by Admin on 12/9/18.
//  Copyright © 2018 Travelogy. All rights reserved.
//

import UIKit

struct Advertiser: ProduceCardViewModel{
    let title: String
    let brandName: String
    let posterName: String
    
    func toCardViewModel() -> CardViewModel{
        let attributedLabel = NSMutableAttributedString(attributedString: NSAttributedString(string: title, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)]))
        attributedLabel.append(NSAttributedString(string: "\n\(brandName)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .bold)]))
        let viewModel = CardViewModel(imageNames: [posterName], attributedText: attributedLabel, textAlignment: .center)
        return viewModel
    }
}
