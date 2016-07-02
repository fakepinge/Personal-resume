//
//  UserLoginViewController.swift
//  Personal resume
//
//  Created by fengli on 16/6/29.
//  Copyright © 2016年 fengli. All rights reserved.
//

import UIKit

protocol UserMessageIdDelegate {
    func returnUserMessageId(userMessageId:String);
}
class UserLoginViewController: UIViewController {

    @IBOutlet weak var bgImage: UIImageView!
    var delegate:UserMessageIdDelegate?
    
    @IBOutlet weak var PhoneNumTextField: FLTextField!
    @IBOutlet weak var PassWordTextField: FLTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    self.view .sendSubviewToBack(self.bgImage)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backToMainVC(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func LoginButtonClicked(sender: AnyObject) {
        let userName = self.PhoneNumTextField.text
        let password:NSString = self.PassWordTextField.text!
        let query:AVQuery = AVQuery(className: "user")
        query.whereKey("phoneNumber", equalTo: userName)

        query.findObjectsInBackgroundWithBlock { (objects, error) in
//            NSLog("%@", error.localizedDescription)
            if error == nil {
                if objects.count > 0 {
                    print(objects)
                    let rightPassword:String = objects.last?.valueForKey("password") as! String
                    if password.isEqualToString(rightPassword) {
                        let userInfoID:String = objects.last?.valueForKey("objectId") as! String
                        self.delegate?.returnUserMessageId(userInfoID)
                        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isOnline")
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }
                }
            }
        }
        
    }
    

    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view .endEditing(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
