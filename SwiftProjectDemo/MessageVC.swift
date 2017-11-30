//
//  MessageVC.swift
//  tableviewDemo
//
//  Created by Chan on 2017/9/15.
//  Copyright © 2017年 Chan. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class MessageVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var tableView:UITableView?;
    var dataArray:NSMutableArray?;
    var isSelected:Bool?;
    
    func subViewWillAppear(_ animated:Bool) -> Void {
        
    }
    func sayHello(_ name:String) -> Void {
        print(name);
    }
    func sayHello2(_ name:String,_ name2:String,_ name3:String) -> Void {
        let strValue = name + name2 + name3;
        print(strValue);
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.sayHello("Chan");
        self.sayHello2("Chan", "King","gentelman");
        
        /*Alamofire.request("https://httpbin.org/get").responseJSON(completionHandler:{
            response in
            print(response.request)
            print(response.response)
            print(response.data)  
            print(response.result) 
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        });*/
        let headers: HTTPHeaders = [
            "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
            "Accept": "application/json"
        ]
        Alamofire.request("https://httpbin.org/get",
                          method: HTTPMethod.get,
                          parameters: nil,
                          encoding: URLEncoding.default,
                          headers: headers).responseJSON(completionHandler: {
                            response in
                            print(response);
                            if let json = response.result.value {
                                let jsonDic = json as? NSDictionary;
                                for (key,value) in jsonDic! {
                                    print("key:\(key),value:\(value)");
                                }
                            }
                          });
        let bundleDic = Bundle.main.infoDictionary;
        for key:String in (bundleDic?.keys)! {
            if key.contains("Ch") {
                print("key = \(key)");
            }
        }
        isSelected = false;
        print(isSelected!);
        dataArray = NSMutableArray.init();
        self.view.backgroundColor = UIColor.white;
        /*tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height), style: UITableViewStyle.plain);
        tableView?.delegate = self;
        tableView?.dataSource = self;
        tableView?.tableFooterView = UIView.init();
        self.view .addSubview(tableView!);*/
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        let detailVC = DetailVC.init(nibName: nil, bundle: nil);
        detailVC.block = {info in
            print(info);
        };
        self.navigationController?.pushViewController(detailVC, animated: true);
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let kcellID = "cellID";
        var cell:UITableViewCell! = tableView.dequeueReusableCell(withIdentifier:kcellID);
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.value1, reuseIdentifier: kcellID);
        }
        cell.textLabel?.text = NSStringFromClass(self.classForCoder).components(separatedBy: ".").last;
        return cell!;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44;
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.hidesBottomBarWhenPushed = false;
        var classStr:String = NSStringFromClass(self.classForCoder);
        classStr = classStr.components(separatedBy: ".").first!;
        print(classStr);
    
    }
    deinit {
        if tableView != nil {
            tableView = nil;
        }
    }
}
