//
//  ViewController.swift
//  JSON
//
//  Created by Nima Emrani on 2/13/16.
//  Copyright © 2016 Nima Emrani. All rights reserved.
//

import UIKit
import Alamofire
import Haneke

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var datas: [JSON] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request(.GET, "https://api.instagram.com/v1/users/27873617/media/recent?access_token=27873617.1677ed0.39204a24ee644f78b3f20bce7aa5be1f").responseJSON { Response in
            var jsonObj = JSON(Response.result.value!)
            if let data = jsonObj["data"].arrayValue as [JSON]? {
                print(data)
                self.datas = data
                self.tableView.reloadData()
                
            }            
        }
    }
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return datas.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ImageCell", forIndexPath: indexPath) as UITableViewCell //1
        let data = datas[indexPath.row]
        if let captionLabel = cell.viewWithTag(100) as? UILabel {
            if let caption = data["caption"]["text"].string{
                captionLabel.text = caption
            }
        }
        if let imageView = cell.viewWithTag(101) as? UIImageView {
            if let urlString = data["images"]["standard_resolution"]["url"].string {
                let url = NSURL(string: urlString)
                imageView.hnk_setImageFromURL(url!)
            }
        }
        return cell
    }
    
}


