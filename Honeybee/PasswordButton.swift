//
//  PasswordButton.swift
//  Honeybee
//
//  Created by Dongbing Hou on 11/04/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class PasswordButton: UIView {

    var selected: Bool = false
    
    var success: Bool = true
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        guard let context:CGContext = UIGraphicsGetCurrentContext() else { return }
        
        if selected {
            if success {
                context.setStrokeColor(red: 2/225, green: 174/255, blue: 240/255, alpha: 1) //线条颜色
                context.setFillColor(red: 2/225, green: 174/255, blue: 240/255, alpha: 1)
            } else {
                context.setStrokeColor(red: 208/255, green: 36/255, blue: 36/255,alpha: 1);//线条颜色
                context.setFillColor(red: 208/255, green: 36/255, blue: 36/255,alpha: 1);
            }
            
            let frame = CGRect(x: bounds.size.width/2-bounds.size.width/8+1, y: bounds.size.height/2-bounds.size.height/8, width: bounds.size.width/4, height: bounds.size.height/4);
            
            context.addEllipse(in: frame);
            context.fillPath();
            
        }else{
            
            context.setStrokeColor(red: 1,green: 1,blue: 1,alpha: 1);//线条颜色
            
        }
        
        context.setLineWidth(2)
        
        let frame:CGRect = CGRect(x: 2, y: 2, width: bounds.size.width-3, height: bounds.size.height-3)
        context.addEllipse(in: frame)
        
        context.strokePath()
        
        if(success){
            context.setFillColor(red: 30/225, green: 175/255, blue: 235/255, alpha: 0.3)
        }else{
            context.setFillColor(red: 208/225, green: 36/255, blue: 36/255, alpha: 0.3)
        }
        
        context.addEllipse(in: frame)
        
        if(selected){
            
            context.fillPath()
        }
    }
    
    
    
}

