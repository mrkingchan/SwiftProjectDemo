//
//  TabbarVC.swift
//  SwiftProjectDemo
//
//  Created by Chan on 2017/9/15.
//  Copyright © 2017年 Chan. All rights reserved.
//

import Foundation
import UIKit

class TabbarVC: UITabBarController {
    
    func viewControllerWithConfig(title:String,classStr:AnyClass,normalImage:UIImage,selectedImage:UIImage) -> UIViewController {
        let viewController:UIViewController? = self.swiftClassFromString(className: title);
        viewController?.navigationItem.title = title.components(separatedBy: ".").last;
            viewController?.tabBarItem = UITabBarItem.init(title: title, image: normalImage, selectedImage: selectedImage);
        return viewController!;
    }
    
    // MARK: private Method
    func viewControllerWithConfig(title:String,classStr:AnyClass,norImage:String,selectedImage:String) -> UIViewController {
        let viewController:UIViewController = self.swiftClassFromString(className: NSStringFromClass(classStr));
        let item = UITabBarItem.init(title: title.components(separatedBy: ".").last, image: UIImage.init(named: norImage), selectedImage: UIImage.init(named: selectedImage));
        viewController.title = title.components(separatedBy: ".").last;
        viewController.tabBarItem = item;
        return viewController;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        let titles = [NSStringFromClass(MessageVC.classForCoder()),
                      NSStringFromClass(ContactVC.classForCoder()),
                      NSStringFromClass(SettingVC.classForCoder())];
        let viewControllers:NSMutableArray = NSMutableArray.init();
        for classStr in titles {
            viewControllers.add(UINavigationController.init(rootViewController: viewControllerWithConfig(title: classStr, classStr: NSClassFromString(classStr)!, norImage: "item", selectedImage:"item")));
            self.viewControllers = viewControllers as? [UIViewController];
        }
        UINavigationBar.appearance().tintColor = UIColor.white;
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.black], for: UIControlState.normal);
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.blue], for: UIControlState.selected);
        
    }
}
