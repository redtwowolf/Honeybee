//
//  KindDetailController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 08/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class KindDetailController: BaseCollectionViewController {
    
    var kind: HoneybeeKind!
    var header: KindDetailHeader!
    
    
    var alertController: UIAlertController!
    
    fileprivate var dataSource: KindDetailDataSource! {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        setNavTitle("衣")
        addHeader()
        addTipView()
        addCollectionView()
        fetchData()
        
    }
    func fetchData() {
        dataSource = KindDetailDataSource(items:kind.items!)
        collectionView.dataSource = dataSource
    }
}


// MARK: UI

extension KindDetailController: HoneybeeViewProvider {
    func addCollectionView() {
        layout.itemSize = CGSize(width: 65, height: 65)
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 50, right: 0)
        collectionView.snp.updateConstraints { (make) in
            make.top.equalTo(115+64)
            make.right.equalTo(view).offset(-60)
        }
        collectionView.register(KindDetailCell.self)
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longGestureAction(_:)))
        collectionView.addGestureRecognizer(longGesture)
    }
    func addHeader() {
        header = KindDetailHeader(frame: CGRect(x: 0, y: 64, width: HB.Screen.w, height: 115))
        header.titleLabel.text = kind.name
        view.addSubview(header)
        
        header.addNewItemAction = { [unowned self] in
            let vc = KindAddItemController()
            vc.kind = self.kind
            self.navigationController?.pushViewController(vc, animated: true)
        }
        header.deleteBtnAction = { btn in
            if btn.isSelected {
                self.allCellEditing()
            } else {
                self.allCellEndEdit()
            }
        }
        header.rightButtonAction = { [unowned self] _ in
            self.showTextFieldAlert()
        }
    }
    
    func showTextFieldAlert() {
        alertController = UIAlertController(title: "设置类名", message: nil, preferredStyle: .alert)
        alertController.addTextField { (tf) in
            NotificationCenter.default.addObserver(self, selector: #selector(self.alertTextFieldTextDidChange(_:)), name: .UITextFieldTextDidChange, object: tf)
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (_) in
            
        }
        let okAction = UIAlertAction(title: "确定", style: .default) { (_) in
            NotificationCenter.default.removeObserver(self, name: .UITextFieldTextDidChange, object: nil)
        }
        okAction.isEnabled = false
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    func alertTextFieldTextDidChange(_ noti: Notification) {
        if let textField = noti.object as? UITextField {
            if let text = textField.text, let okAction = alertController.actions.last {
                okAction.isEnabled = text.characters.count > 0
                var targetText = ""
                if text.characters.count > 4 {
                    let offset = text.index(text.startIndex, offsetBy: 4)
                    targetText = text.substring(to: offset)
                } else {
                    targetText = text
                }
                print(targetText)
            }
        }
    }
    
    func addTipView() {
    let frame = CGRect(x: HB.Screen.w - 50, y: 200, width: 50, height: 130)
        tipLabel(text: "长 按 可 删 除", frame: frame)
    }
    
    
}



// MARK: long press to delete

extension KindDetailController {
    func allCellEditing() {
        dataSource = KindDetailDataSource(items: kind.items!, isEditing: true)
        collectionView.dataSource = dataSource
    }
    func allCellEndEdit() {
        dataSource = KindDetailDataSource(items: kind.items!, isEditing: false)
        collectionView.dataSource = dataSource
    }
    func longGestureAction(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            allCellEditing()
            header.deleteBtn.isSelected = true
            
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
}



// MARK: UICollectionViewDelegateFlowLayout

extension KindDetailController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("-------\(indexPath.section)----\(indexPath.row)")
    }
}
