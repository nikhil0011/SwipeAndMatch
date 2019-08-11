//
//  CardViewModel.swift
//  SwipeAndMatch
//
//  Created by Admin on 12/8/18.
//  Copyright © 2018 Travelogy. All rights reserved.
//

import UIKit

protocol ProduceCardViewModel{
    func toCardViewModel() -> CardViewModel
}

struct CardViewModel{
    //We'll define here what properties our card will display and render out here 
    let imageNames: [String]
    let attributedText: NSAttributedString
    let textAlignment: NSTextAlignment
 }

