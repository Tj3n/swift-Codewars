//: [Previous](@previous)

import Foundation
import UIKit
import PlaygroundSupport

let containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0))
PlaygroundPage.current.liveView = containerView

let circle = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 50.0, height: 50.0))
circle.center = containerView.center
circle.layer.cornerRadius = 25.0

let startingColor = UIColor(red: (253.0/255.0), green: (159.0/255.0), blue: (47.0/255.0), alpha: 1.0)
circle.backgroundColor = startingColor

containerView.addSubview(circle);

let rectangle = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 50.0, height: 50.0))
rectangle.center = containerView.center
rectangle.layer.cornerRadius = 5.0

rectangle.backgroundColor = UIColor.white

containerView.addSubview(rectangle)

UIView.animate(withDuration: 2, delay: 0, options: [.curveEaseInOut,.autoreverse,.repeat], animations: { 
    let endingColor = UIColor(red: (255.0/255.0), green: (61.0/255.0), blue: (24.0/255.0), alpha: 1.0)
    circle.backgroundColor = endingColor
    
    let scaleTransform = CGAffineTransform(scaleX: 5.0, y: 5.0)
    
    circle.transform = scaleTransform
    
    let rotationTransform = CGAffineTransform(rotationAngle: 3.14)
    
    rectangle.transform = rotationTransform
}) { (complete) in
    
}

let t = Timer.scheduledTimer(withTimeInterval: 9, repeats: false) { (timer) in
    UIView.animate(withDuration: 0.5, delay: 0, options: [.beginFromCurrentState,.curveEaseOut], animations: { 
        rectangle.transform = CGAffineTransform.identity
        circle.transform = CGAffineTransform(scaleX: 4.0, y: 4.0)
        circle.backgroundColor = startingColor
    }, completion: { (complete) in
        timer.invalidate()
        
        let l = CGAffineTransform(rotationAngle: CGFloat(-20*M_PI/180))
        let r = CGAffineTransform(rotationAngle: CGFloat(20*M_PI/180))
        
//        rectangle.transform = l
//        UIView.beginAnimations("shake", context: nil)
//        UIView.setAnimationRepeatAutoreverses(true) // important
//        UIView.setAnimationRepeatCount(5)
//        UIView.setAnimationCurve(.easeInOut)
//        UIView.setAnimationDuration(0.5)
//        UIView.setAnimationDidStop(Selector(("animationDidStop:finished:context:"))) //Need class to call
////        UIView.setAnimationDelegate:self
//        rectangle.transform = r
//        UIView.commitAnimations()
        
//: or
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.7, options: [.curveEaseInOut], animations: {
            rectangle.transform = CGAffineTransform(translationX: 0, y: 80)
        }, completion: { (completed) in
            
        })
    })
}

 //Need class to call
func animationDidStop(animationId: String?, finished: NSNumber, context: UnsafeMutableRawPointer) {
    rectangle.transform = CGAffineTransform.identity
}
//: [Next](@next)
