//
//  ProfileHeader.swift
//  Honeybee
//
//  Created by Dongbing Hou on 13/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class ProfileHeader: UIView {

    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = HonybeeFont.h4
        label.textColor = UIColor.white
        label.text = "累计记账"
        return label
    }()
    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.font = HonybeeFont.h1_big
        label.textColor = UIColor.white
        label.text = "179天"
        return label
    }()
    
    lazy var containView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.isUserInteractionEnabled = false
        view.backgroundColor = HonybeeColor.main
        return view
    }()
    
    lazy var editButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("编辑", for: .normal)
        btn.setTitleColor(HonybeeColor.main, for: .normal)
        btn.titleLabel?.font = HonybeeFont.h4
        return btn
    }()
    
    
    convenience init(height: CGFloat) {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: height))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(editButton)
        addSubview(containView)
        containView.addSubview(titleLabel)
        containView.addSubview(countLabel)
        
        editButton.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(self).offset(-10)
            make.width.equalTo(40)
        }
        
        containView.snp.makeConstraints { (make) in
            make.left.top.equalTo(self).offset(10)
            make.right.equalTo(editButton.snp.left).offset(-10)
            make.height.equalTo(self)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(containView).offset(10)
        }
        
        countLabel.snp.makeConstraints { (make) in
            make.center.equalTo(containView)
        }
    
        
    }

}