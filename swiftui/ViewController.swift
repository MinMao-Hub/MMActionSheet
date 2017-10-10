//
//  ViewController.swift
//  swiftui
//
//  Created by 郭永红 on 2017/10/9.
//  Copyright © 2017年 keeponrunning. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var tableView = UITableView()
    let cellIdentifier = "exampleCell"
    var dataSource: [NSDictionary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        self.view.addSubview(tableView)
        
        //读取plist文件
        if let path = Bundle.main.path(forResource: "Components", ofType: "plist") {
            dataSource = NSArray.init(contentsOfFile: path) as! [NSDictionary]
        }
        
        //过滤未开发的内容
        var devDatas: [NSDictionary] = []
        for item in dataSource {
            let disable:Bool = item.object(forKey: "disable") as! Bool
            if !disable {
                devDatas.append(item)
            }
        }
        
        dataSource = devDatas
    }
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var keyName = ""
        let keyNames = dataSource[indexPath.row].allKeys
        for item in keyNames {
            let _keyName:String = item as! String
            if _keyName == "disable" {
                
            } else {
                keyName = _keyName
            }
        }
        
        
        let classNameStr:String = dataSource[indexPath.row][keyName] as! String
        
        //反射类的方式
//        let className = Bundle.main.infoDictionary!["CFBundleName"] as! String + "." + classNameStr
//        let clazz:UIViewController.Type = NSClassFromString(className) as! UIViewController.Type
//        let objectVc = clazz.init()
        
        //storyboard初始化方式
        let examStoryboard = UIStoryboard.init(name: "Example", bundle: Bundle.main)
        let objectVc = examStoryboard.instantiateViewController(withIdentifier: classNameStr)
        
        objectVc.title = keyName
        
        self.navigationController?.pushViewController(objectVc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let label = UILabel()
        
        var keyName = ""
        let keyNames = dataSource[indexPath.row].allKeys
        for item in keyNames {
            let _keyName:String = item as! String
            if _keyName == "disable" {
                
            } else {
                keyName = _keyName
            }
        }
        
        
        label.text = keyName
        label.frame = CGRect.init(x: 20, y: 0, width: cell.bounds.size.width, height: cell.bounds.size.height);
        cell.addSubview(label)
        
        return cell
    }
}

