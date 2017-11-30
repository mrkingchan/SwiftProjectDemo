//
//  DropDownView.swift
//  SwiftProjectDemo
//
//  Created by Chan on 2017/9/20.
//  Copyright © 2017年 Chan. All rights reserved.
//

import Foundation
import UIKit

typealias complete = (String,Int)->();

class DropDownView: UIView,UITableViewDataSource,UITableViewDelegate {
    
    var tableView:UITableView?;
    var dataArray:NSArray?;
    var imagesArray:NSArray?;
    
    var completeVar:complete?;
    let postion:CGRect? = nil;
    
    class func dropViewWithConfigure(position:CGRect,
                                     titles:NSArray,
                                     images:NSArray,
                                     completeBlock:@escaping complete) -> DropDownView {
        return DropDownView.init(position: position, titles: titles, images: images, completeBlock: completeBlock);
    }
    
    // MARK: init初始化构造方法
    init(position:CGRect,
         titles:NSArray,
         images:NSArray,
         completeBlock:@escaping complete) {
        super.init(frame: UIScreen.main.bounds);
        completeVar = completeBlock;
        dataArray = titles ;
        imagesArray = images;
        self.backgroundColor = UIColor.init(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.4);
        UIApplication.shared.keyWindow?.addSubview(self);

        //tableView初始化
        tableView = UITableView.init(frame: CGRect.init(x: position.origin.x, y: position.origin.y, width: position.size.width, height:position.size.height), style: UITableViewStyle.plain);
        tableView?.delegate = self;
        tableView?.dataSource = self;
        tableView?.tableFooterView = UIView.init();
        tableView?.clipsToBounds = true;
        tableView?.layer.cornerRadius = 5.0;
        self.addSubview(tableView!);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UITableViewDelegate&DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dataArray?.count)!;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        if completeVar != nil {
            completeVar!((dataArray?.object(at: indexPath.row)as!String),indexPath.row);
        }
        self.removeFromSuperview();
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let kcellID = "cellID";
        var cell:UITableViewCell! = tableView.dequeueReusableCell(withIdentifier:kcellID);
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.value1, reuseIdentifier: kcellID);
        }
        cell.textLabel?.textAlignment = NSTextAlignment.center;
        cell.textLabel?.text = (dataArray?.object(at: indexPath.row) as! String);
        cell.imageView?.image = UIImage.init(named: (imagesArray?.object(at: indexPath.row) as!String));
        return cell!;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44;
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.removeFromSuperview();
    }
    // MARK: memory Management 
    deinit {
        tableView = nil;
        
    }
}
