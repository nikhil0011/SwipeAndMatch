//
//  UserDetailViewController.swift
//  SwipeAndMatch
//
//  Created by Nikhil on 15/07/19.
//  Copyright © 2019 Travelogy. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController,UIScrollViewDelegate {
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .green
        sv.alwaysBounceVertical = true
        sv.contentInsetAdjustmentBehavior = .never
        sv.delegate = self
        return sv
    }()
    
    let imageview: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "jane1"))
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "User name: JOHN\n Age: 30 Yrs:Some bio text down"
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(imageview)
        //Frame
        imageview.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width)
        // Do any additional setup after loading the view.
        scrollView.addSubview(infoLabel)
        infoLabel.anchor(top: imageview.bottomAnchor, leading: imageview.leadingAnchor, bottom: nil, trailing: imageview.trailingAnchor,padding: .init(top: 8, left: 8, bottom: 8, right: 8))
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let changeY = -scrollView.contentOffset.y
        var width = view.frame.width + changeY * 2
        width = max(width,self.view.frame.width)
        imageview.frame = CGRect(x: min(0,-changeY), y: min(0,-changeY), width: width, height: width)
    }
}
