//
//  KindViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 07/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class KindViewController: BaseCollectionViewController {

    
    var dataSource = ["衣", "食", "住", "行", "购物", "衣", "食", "住", "行", "购物"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavTitle("添加图标")
        setNavRightItem("添加种类")
        addCollectionView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    func addCollectionView() {
        layout.itemSize = CGSize(width: 150, height: 165)
        layout.minimumLineSpacing = 25
        layout.minimumInteritemSpacing = 25
        layout.sectionInset = UIEdgeInsets(top: 0, left: 25, bottom: 25, right: 25)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        collectionView.register(KindCell.self)
    }
    override func navRightItemClicked() {
        navigationController?.pushViewController(KindAddViewController(), animated: true)
    }
}


// MARK: UICollectionViewDataSource
extension KindViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(KindCell.self)", for: indexPath) as! KindCell
        cell.titleLabel.text = dataSource[indexPath.item]
        return cell
    }
}


// MARK: UICollectionViewDelegateFlowLayout
extension KindViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("-------\(indexPath.section)----\(indexPath.row)")
    }
}
