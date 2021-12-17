//
//  Util.swift
//  PairListBtc
//
//  Created by İbrahim Demirci on 9.12.2021.
//

import UIKit

fileprivate var aView : UIView?

extension UIViewController{
    
    func showSpinner(){
        
        aView = UIView(frame: self.view.bounds)
        aView?.backgroundColor = .black
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.center = aView!.center
        activityIndicator.startAnimating()
        aView?.addSubview(activityIndicator)
        self.view.addSubview(aView!)
    }
    
    func removeSpinner(){
        aView?.removeFromSuperview()
        aView = nil
    }
}


