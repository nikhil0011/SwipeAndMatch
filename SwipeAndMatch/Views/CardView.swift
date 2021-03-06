//
//  CardView.swift
//  SwipeAndMatch
//
//  Created by Admin on 11/11/18.
//  Copyright © 2018 Travelogy. All rights reserved.
//

import UIKit

class CardView: UIView {
    fileprivate let barDeselectColor: UIColor = UIColor(white: 0, alpha: 0.1)
    var cardViewModel: CardViewModel!{
        didSet{
            if let imageName = cardViewModel.imageNames.first{
                imageView.image = UIImage(named: imageName)
            }
            informationLabel.attributedText = cardViewModel.attributedText
            informationLabel.textAlignment = cardViewModel.textAlignment
            (0..<cardViewModel.imageNames.count).forEach{(_) in
                let barView = UIView()
                barView.backgroundColor = barDeselectColor
                barsStackView.addArrangedSubview(barView)
            }
            barsStackView.arrangedSubviews.first?.backgroundColor = .white
        }
    }
    let gradientLayer = CAGradientLayer()
    fileprivate let imageView: UIImageView = UIImageView(image: #imageLiteral(resourceName: "lady5c"))
    fileprivate let thershold: CGFloat = 100
    fileprivate let informationLabel: UILabel =  UILabel()
    fileprivate let barsStackView: UIStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        let panGeusture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gesture:)))
        addGestureRecognizer(panGeusture)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }
    var imageIndex: Int = 0
    
    @objc func handleTap(gestue: UITapGestureRecognizer){
        debugPrint("Handling Tap Gesture")
        let tapLocation = gestue.location(in: nil)
        let shouldAdvanceToNextPhoto = tapLocation.x > frame.width / 2 ? true : false
        if shouldAdvanceToNextPhoto{
            imageIndex = min(imageIndex + 1,cardViewModel.imageNames.count - 1)
        }else{
            imageIndex = max(imageIndex - 1,0)
        }
        let imageName = cardViewModel.imageNames[imageIndex]
        imageView.image = UIImage(named: imageName)
        barsStackView.arrangedSubviews.forEach({ (v) in
            v.backgroundColor = barDeselectColor
        })
        barsStackView.arrangedSubviews[imageIndex].backgroundColor = .white
    }
    
    fileprivate func setupLayout() {
        addSubview(imageView)
        imageView.fillSuperview()
        imageView.contentMode = .scaleAspectFill
        setupBarStackView()
        setupGradientLayer()
        addSubview(informationLabel)
        let informationLabelInset = UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 0)
        informationLabel.anchor(top: nil, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: trailingAnchor, padding: informationLabelInset)
        informationLabel.textColor = .white
        informationLabel.numberOfLines = 0
        informationLabel.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        clipsToBounds = true
        layer.cornerRadius = 10
    }
    
    func setupGradientLayer(){
        gradientLayer.colors = [UIColor.clear.cgColor,UIColor.black.cgColor]
        gradientLayer.locations = [0.5,1.3]
        layer.addSublayer(gradientLayer)
    }
    
    func setupBarStackView(){
        addSubview(barsStackView)
        barsStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 8, left: 8, bottom: 0, right: 8),size: .init(width: 0, height: 4))
        barsStackView.spacing = 1
        barsStackView.distribution = .fillEqually
        barsStackView.layer.cornerRadius = 3
    }
    override func layoutSubviews() {
        gradientLayer.frame = self.frame
    }
    
    fileprivate func handleGesutreEnded(_ gesture: UIPanGestureRecognizer){
        let transalation = gesture.translation(in: nil)
        let transalationDirection: CGFloat = transalation.x > 0 ? 1 : -1
        let shouldDismissCard = abs(transalation.x) > thershold
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            //Default Value for transform ".identity"
            if shouldDismissCard {
                /*
                 Option 1:(Buggy)
                 * MARK:- Changing transformation via "self.transform.translatedBy" of view
                 * will give you sudden Bumpy / jumpy effect of card getting removed.
                 FOR REFERENCE PLEASE CHECK BELOW COMMENTED TWO LINES OF CODE.
                 * --> let transform = self.transform.translatedBy(x: 1000, y: 0)
                 * --> self.transform = transform
                 */
                /*
                 Option 2:(Optimised)
                 * MARK:- To Overcome this issuse we can apply change in frame paramteres
                 *
                 * MARK:- We are superview.frame rather can usual self.frame directly as while we are
                 * Transforming our card on run time It's frame is getting effected it will return
                 * you unexpected sizes every time.
                 * Whereas, Superview Frame size is fixes throughout.
                 */
                self.frame = CGRect(x: transalationDirection * 1000, y: 0, width: self.superview!.frame.width, height: self.superview!.frame.height)
            }else{
                self.transform = .identity
            }
        }, completion: {( _) in
            print("Completion Block for handleGesutreEnded method called")
            self.transform = .identity
            if shouldDismissCard{
                self.removeFromSuperview()
            }
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
        /*
         *MARK:- Only Moving the position with below line
         self.transform = CGAffineTransform(translationX: transalation.x, y: transalation.y)
         */
        
    }
    
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer){
        switch gesture.state{
        case .began:
            //Remove all animation before you begin any new animation as multiple animation are going on at individual element itself. 
            superview?.subviews.forEach({ (subview) in
                subview.layer.removeAllAnimations()
            })
        case .changed:
            handleGestureChange(gesture)
            break
        case .ended:
            handleGesutreEnded(gesture)
            break
        default:
            break
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
