//
//  AssetImageView.swift
//  Collections
//
//  Created by vinod chari on 8/10/16.
//  Copyright © 2016 avastavik. All rights reserved.
//

import UIKit


class AssetImageView: UIImageView {
    
    var lastLocation:CGPoint?
    var panRecognizer:UIPanGestureRecognizer?
    
    init(imageIcon: UIImage?, rect:CGRect) {
        super.init(image: imageIcon)
        self.userInteractionEnabled = true
        self.multipleTouchEnabled = true
        
        self.lastLocation = rect.origin
        self.frame = rect
        self.center = rect.origin
        
        addGestureRecognizer(UIPanGestureRecognizer(target:self, action:#selector(AssetImageView.detectPan(_:))))
        addGestureRecognizer(UIPinchGestureRecognizer(target: self,action:#selector(AssetImageView.detectPinch(_:))))
        addGestureRecognizer( UIRotationGestureRecognizer(target:self,action:#selector(AssetImageView.detectRotation(_:))))

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func detectPan(recognizer:UIPanGestureRecognizer) {
        let translation  = recognizer.translationInView(self.superview!)
        self.center = CGPointMake(lastLocation!.x + translation.x, lastLocation!.y + translation.y)
    }
    func detectPinch(sender:UIPinchGestureRecognizer)  {
   
        sender.view!.transform = CGAffineTransformScale(sender.view!.transform, sender.scale, sender.scale)
        sender.scale = 1.0
    }
    func detectRotation(recognizer:UIRotationGestureRecognizer)  {
        if let view = recognizer.view {
            view.transform = CGAffineTransformRotate(view.transform, recognizer.rotation)
            recognizer.rotation = 0
        }
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // Promote the touched view
        self.superview?.bringSubviewToFront(self)
        
        // Remember original location
        lastLocation = self.center
    }
    
}

