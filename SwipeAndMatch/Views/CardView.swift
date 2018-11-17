//
//  CardView.swift
//  SwipeAndMatch
//
//  Created by Admin on 11/11/18.
//  Copyright © 2018 Travelogy. All rights reserved.
//

import UIKit

class CardView: UIView {
    fileprivate let imageView: UIImageView = UIImageView(image: #imageLiteral(resourceName: "lady5c"))
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.fillSuperview()
        clipsToBounds = true
        layer.cornerRadius = 10
        let panGeusture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gesture:)))
        addGestureRecognizer(panGeusture)
    }
    
    fileprivate func handleGesutreEnded() {
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            //Default Value for transform ".identity"
            self.transform = .identity
        }, completion: {( _) in
            
        })
    }
    
    fileprivate func handleGestureChange(_ gesture: UIPanGestureRecognizer) {
        let transalation = gesture.translation(in: nil)
        /*
         *MARK:- "transform" Use this property to scale,move or rotate the view's frame rectangle within its superview's coordinate system. (To change the position of the view, modify the center property instead.) The default value of this property is CGAffineTransformIdentity.
         */
        //Convert Raidans To degree
        //MARK:- This CGAffineTransform(rotationAngle: 15) method takes value in Radians
        let degree: CGFloat = transalation.x / 20
        let angleInRadians = degree * .pi / 180
        let rotationalTransformation = CGAffineTransform(rotationAngle: angleInRadians)
        /*
         *MARK:- translatedBy is helping to transalte x and y position of view while rotational transformation is occuring
         **/
        self.transform = rotationalTransformation.translatedBy(x: transalation.x, y: transalation.y)
        
//        self.transform = CGAffineTransform(translationX: transalation.x, y: transalation.y)
    }
    
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer){
        
        switch gesture.state{
        case .changed:
            handleGestureChange(gesture)
            break
        case .ended:
            handleGesutreEnded()
            break
        default:
            break
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
