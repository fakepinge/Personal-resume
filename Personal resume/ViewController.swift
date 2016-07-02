//
//  ViewController.swift
//  Personal resume
//
//  Created by fengli on 16/6/25.
//  Copyright © 2016年 fengli. All rights reserved.
//

import UIKit

let personalCellIdentifier = "PersonalTableViewCell"
let educationCellIdentifier = "EducationTableViewCell"
let experienceCellIdentifier = "ExperienceTableViewCell"
let caseCellIdentifier = "CaseTableViewCell"
let computerCellIdentifier = "ComputerTableViewCell"
let evaluateCellIdentifier = "EvaluateTableViewCell"



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UserMessageIdDelegate {


    @IBOutlet weak var coverImageViewTop: NSLayoutConstraint!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var selfInfoTableView: UITableView!
    @IBOutlet weak var maskView: UIView!
    var currentHeaderLabel: UILabel!
    var name: String = "请登录"
    
    var iconImageView: UIImageView!
    var cellNumber:Int = 0
    var dataObject:AVObject?
    // MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1)
        self.setupIconImageView()
        self.setupTableView()
        if NSUserDefaults.standardUserDefaults().valueForKey("isOnline") != nil {
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isOnline")
        }
    }
    
    // MARK: - 初始化TableView
    func setupTableView() {
        
        let topInset = UIScreen.mainScreen().bounds.height / 2.0
        self.automaticallyAdjustsScrollViewInsets = false
        self.selfInfoTableView.contentInset = UIEdgeInsets(top: topInset - 64.0, left: 0, bottom: 0, right: 0)

        self.registerNibCell(personalCellIdentifier)
        self.registerNibCell(educationCellIdentifier)
        self.registerNibCell(experienceCellIdentifier)
        self.registerNibCell(caseCellIdentifier)
        self.registerNibCell(computerCellIdentifier)
        self.registerNibCell(evaluateCellIdentifier)

    }
    
    func registerNibCell(cellString: String)  {
        self.selfInfoTableView.registerNib(UINib.init(nibName: cellString, bundle: NSBundle.mainBundle()), forCellReuseIdentifier: cellString)
    }
    
    func setupIconImageView() {
        iconImageView = UIImageView()
        let screenWidth = UIScreen.mainScreen().bounds.width
        iconImageView.bounds = CGRectMake(0, 0, 80, 80)
        iconImageView.center = CGPoint(x: screenWidth/2.0, y: 220.0 + 64)
        self.view.addSubview(iconImageView)
        iconImageView.backgroundColor = UIColor.whiteColor()
        iconImageView.image = UIImage(named: "icon")
        iconImageView.layer.cornerRadius = 40
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.borderWidth = 1
        iconImageView.layer.borderColor = UIColor.blackColor().CGColor
        
        iconImageView.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(presentUserLoginVC))
        iconImageView.addGestureRecognizer(tap)

    }
    
    func presentUserLoginVC() {
        if NSUserDefaults.standardUserDefaults().valueForKey("isOnline") != nil {
            let isOnline:Bool = (NSUserDefaults.standardUserDefaults().valueForKey("isOnline")?.boolValue)!
            if isOnline {
                let alertVC:UIAlertController = UIAlertController(title: "退出登录", message: "是否退出登录？", preferredStyle: .Alert)
                let cancleAction:UIAlertAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
                let logoutAction:UIAlertAction = UIAlertAction(title: "确定", style: .Default, handler: { (action) in
                    NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isOnline")
                    self.cellNumber = 0;
                    dispatch_async(dispatch_get_main_queue(), {
                        self.iconImageView.image = UIImage(named: "icon")
                        self.name = "请登录"
                        self.selfInfoTableView.reloadData()
                    })
                    
                })
                alertVC.addAction(cancleAction)
                alertVC.addAction(logoutAction)
                self.presentViewController(alertVC, animated: true, completion: nil)
            }
            else {
                let userLoginVC:UserLoginViewController = UserLoginViewController()
                userLoginVC.delegate = self
                self.presentViewController(userLoginVC, animated: true, completion: nil)
            }
        }
        
        
        else {
            let userLoginVC:UserLoginViewController = UserLoginViewController()
            userLoginVC.delegate = self
            self.presentViewController(userLoginVC, animated: true, completion: nil)
        }
        
    }
    
    func returnUserMessageId(userMessageId: String) {
        
        let query:AVQuery = AVQuery(className: "userMessage")
        query.whereKey("userId", equalTo: userMessageId)
        query.findObjectsInBackgroundWithBlock { (objects, error) in
            if error == nil {
                if objects.count > 0 {
                    self.dataObject = objects.last as? AVObject
                    self.cellNumber = 8
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        self.name = self.dataObject?.valueForKey("name") as! String
                        self.selfInfoTableView.reloadData()
                        if self.dataObject?.valueForKey("iconBool") as! Bool {
                            self.iconImageView.image = UIImage(named: "me")
                        } else {
                            self.iconImageView.image = UIImage(named: "self.jpg")
                        }
                    })
                }
            }
        }
        
    }
    
    // MARK: - UITableViewDelegate UITableViewDataSource
    // ---cell个数---
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellNumber
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var cellHeight: Double = 0
        switch indexPath.row {
        case 0:
            cellHeight = 300
        case 1:
            cellHeight = 115
        case 2:
            cellHeight = 295
        case 3:
            cellHeight = 220
        case 4:
            cellHeight = 220
        case 5:
            cellHeight = 220
        case 6:
            cellHeight = 400
        case 7:
            cellHeight = 230
        default:
            cellHeight = 0
        }
        return  CGFloat(cellHeight)
    }
    // ---cell---
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cellString: String?
        switch indexPath.row {
        case 0:
            cellString = personalCellIdentifier
            let cell = tableView.dequeueReusableCellWithIdentifier(cellString!, forIndexPath: indexPath) as! PersonalTableViewCell
            cell.phoneNumLabel.text = dataObject?.valueForKey("phoneNumber") as? String
            cell.mailLabel.text = dataObject?.valueForKey("mail") as? String
            cell.workTime.text = dataObject?.valueForKey("workTime") as? String
            return cell
        case 1:
            cellString = educationCellIdentifier
        case 2:
            cellString = experienceCellIdentifier
            let cell = tableView.dequeueReusableCellWithIdentifier(cellString!, forIndexPath: indexPath) as! ExperienceTableViewCell
            cell.oneTimeLabel.text = (dataObject?.valueForKey("timeSegment") as? [String])?.first
            cell.secondTimeLabel.text = (dataObject?.valueForKey("timeSegment") as? [String])?.last
            cell.oneCompanyLabel.text = (dataObject?.valueForKey("companys") as? [String])?.first
            cell.secondCompanyLabel.text = (dataObject?.valueForKey("companys") as? [String])?.last
            return cell
        case 3:
            cellString = caseCellIdentifier
        case 4:
            cellString = caseCellIdentifier
        case 5:
            cellString = caseCellIdentifier
        case 6:
            cellString = computerCellIdentifier
            let cell = tableView.dequeueReusableCellWithIdentifier(cellString!, forIndexPath: indexPath) as! ComputerTableViewCell
            cell.label.text = dataObject?.valueForKey("skill") as? String
            return cell
        case 7:
            cellString = evaluateCellIdentifier
            let cell = tableView.dequeueReusableCellWithIdentifier(cellString!, forIndexPath: indexPath) as! EvaluateTableViewCell
            cell.label.text = dataObject?.valueForKey("evaluate") as? String
            return cell
        default:
            cellString = nil
        }
        let cell = tableView.dequeueReusableCellWithIdentifier(cellString!, forIndexPath: indexPath)
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 3 {
            self.openApplication("idlesse://")
        } else if (indexPath.row == 4) {
            self.openApplication("ooofans://")
        } else if (indexPath.row == 5) {
            self.openApplication("wsgw://")
        }
    }
    func openApplication(urlString: String)  {
        let url = NSURL(string: urlString)
        if UIApplication.sharedApplication().canOpenURL(url!) {
            UIApplication.sharedApplication().openURL(url!)
        }

    }
    // ---headerView---
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: UIView = NSBundle.mainBundle().loadNibNamed("HeaderView", owner: nil, options: nil).first as! UIView
        let nameLabel = headerView.subviews.first as! UILabel
        nameLabel.text = self.name
        self.currentHeaderLabel = nameLabel
        return headerView
    }
    // ---headerViewHeight---
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {

        let contentOffsetY = self.selfInfoTableView.contentOffset.y
        self.maskView.alpha = (contentOffsetY + 220)/550
        if contentOffsetY >= 0 {
            self.selfInfoTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            self.iconImageView.center.y = 64
        }
        else {
            if contentOffsetY < -220 {
                self.selfInfoTableView.contentInset = UIEdgeInsets(top: 220, left: 0, bottom: 0, right: 0)
                self.coverImageView.frame.size.height = 63.5 - contentOffsetY;
            }
            else {
                self.selfInfoTableView.contentInset = UIEdgeInsets(top: -contentOffsetY, left: 0, bottom: 0, right: 0)
                self.iconImageView.center.y = -contentOffsetY + 64
                self.coverImageViewTop.constant = -(contentOffsetY + 220)/2.0
            }
            
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}

