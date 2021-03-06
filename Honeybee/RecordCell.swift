//
//  RecordCell.swift
//  Honeybee
//
//  Created by Dongbing Hou on 08/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit
import SnapKit

class RecordCell: UITableViewCell {
    
    lazy var imgView = UIImageView(image: UIImage(named: "meal"))
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = HB.Font.h4_number
        return label
    }()
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = HB.Font.h5_medium
        return label
    }()
    lazy var weekdayLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = HB.Font.h7
        return label
    }()
    lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = HB.Font.h3_number
        return label
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        layer.cornerRadius = HB.Constant.cornerRadius
        
        initialize()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override var frame: CGRect {
        didSet {
            var newFrame = frame
            newFrame.origin.x += 10
            newFrame.origin.y += 10
            newFrame.size = CGSize(width: frame.width-20, height: frame.height-20)
            super.frame = newFrame
            
        }
    }
    
    var recorder: RLMRecorder! {
        didSet {
            imgView.image = UIImage(named: recorder.imageName)
            dateLabel.text = recorder.monthDay
            categoryLabel.text = recorder.category
            numberLabel.text = formatter(num: recorder.money)//"\(recorder.money)"
            weekdayLabel.text = recorder.weekday
            backgroundColor = UIColor(hex: recorder.color)
        }
    }
    
    func formatter(num: Double) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: num)) ?? "0"
    }
    func initialize() {
        contentView.addSubview(imgView)
        contentView.addSubview(dateLabel)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(weekdayLabel)
        contentView.addSubview(numberLabel)
        
        imgView.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(10)
            make.centerY.equalTo(contentView)
            make.width.height.equalTo(45)
        }
        
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imgView)
            make.bottom.equalTo(imgView.snp.centerY)
            make.left.equalTo(imgView.snp.right).offset(10)
            make.width.equalTo(100)
        }
        categoryLabel.snp.makeConstraints { (make) in
            make.top.equalTo(dateLabel.snp.bottom)
            make.bottom.equalTo(imgView.snp.bottom)
            make.left.width.equalTo(dateLabel)
        }
        weekdayLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(10)
            make.right.equalTo(contentView.snp.right).offset(-10)
            make.width.equalTo(40)
            make.height.equalTo(20)
        }
        numberLabel.snp.makeConstraints { (make) in
            make.right.equalTo(weekdayLabel.snp.right)
            make.left.equalTo(categoryLabel.snp.right)
            make.top.equalTo(weekdayLabel.snp.bottom)
            make.bottom.equalTo(categoryLabel.snp.bottom)
        }
        
    }
}
