//
//  DetailVC.swift
//  SwiftProjectDemo
//
//  Created by Chan on 2017/9/19.
//  Copyright © 2017年 Chan. All rights reserved.
//

import Foundation
import UIKit
//别名
typealias MyBlock = (String)->();

class DetailVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var block:MyBlock?;
    var block2:((String)->())?;
    var complete:((String)->())?;  //block一般要写为可选值
    var complete2:((String)->())?;
    var tableView:UITableView?;
    
    // MARK: lifeCircle
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.orange;
        self.navigationItem.title = NSStringFromClass(self.classForCoder).components(separatedBy: ".").last;
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "完成", style: UIBarButtonItemStyle.plain, target: self, action: NSSelectorFromString("buttonActionWithSender:"));
        
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height), style: UITableViewStyle.plain);
        tableView?.delegate = self;
        tableView?.dataSource = self;
        tableView?.tableFooterView = UIView.init();
        self.view .addSubview(tableView!);
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        weak var weakself = self;  //weak的值总是可选的
        if complete != nil {
            complete!("Chan");
            weakself!.view.backgroundColor = UIColor.red;
        }
    }
    
    // MARK: private Method
    func buttonAction(sender:AnyObject) -> Void {
        if sender.isKind(of: UIBarButtonItem.classForCoder()) {
            self.navigationController?.popViewController(animated: true);
            block!(NSStringFromClass(self.classForCoder));
        } else if sender.isKind(of: UIButton.classForCoder()) {
            let button = sender as! UIButton;
            if button.tag == 100 {
                if nil != complete2 {
                    complete2!("Chan");
                }
            } else if button.tag == 101 {
            }
        }
    }
    
    // MARK: UITableViewDataSouce&Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let kcellID = "cellID";
        var cell:UITableViewCell! = tableView.dequeueReusableCell(withIdentifier:kcellID) ;
        if cell == nil {
        cell = UITableViewCell.init(style: UITableViewCellStyle.value1, reuseIdentifier: kcellID);
        }
        cell.textLabel?.text = NSStringFromClass(self.classForCoder).components(separatedBy: ".").last
        return cell!;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44;
    }
}
