//
//  ProductVC.swift
//  SwiftProjectDemo
//
//  Created by Chan on 2017/9/20.
//  Copyright © 2017年 Chan. All rights reserved.
//

import Foundation
import UIKit
class ProductVC:UIViewController,UICollectionViewDataSource,UICollectionViewDelegate  {
    var collectionView:UICollectionView?;
    var dataArray:NSMutableArray?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white;
        self.setUI();
    }
    
    // MARK: setUI
    func setUI()->Void {
        let layout = UICollectionViewFlowLayout.init();
        layout.itemSize = CGSize.init(width: (UIScreen.main.bounds.size.width - 20)/3 , height: 120);
        layout.minimumLineSpacing = 5.0;
        layout.sectionInset = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5);
        layout.minimumInteritemSpacing = 5.0;
        collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height ), collectionViewLayout: layout);
        collectionView?.backgroundColor = UIColor.gray;
        collectionView?.delegate = self;
        collectionView?.dataSource = self;
        collectionView?.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier:"cell");
        self.view.addSubview(collectionView!);
    }
    
    // MARK: UITableViewDataSource&Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100;
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath);
        cell.backgroundColor = UIColor.orange;
        return cell;
    }
}
