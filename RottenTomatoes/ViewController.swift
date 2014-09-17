//
//  ViewController.swift
//  RottenTomatoes
//
//  Created by Saket Agarwal on 9/15/14.
//  Copyright (c) 2014 Saket Agarwal. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var movieTableView: UITableView!
    
    var pullToRefreshControll:UIRefreshControl!
    var moviesArray:NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pullToRefreshControll = UIRefreshControl()
        self.pullToRefreshControll.attributedTitle = NSAttributedString(string: "Pull to refersh")
        self.pullToRefreshControll.addTarget(self, action: "getRottenTomatoData", forControlEvents: .ValueChanged)
        movieTableView.addSubview(pullToRefreshControll)
        getRottenTomatoData()
      
    }


   func getRottenTomatoData(){
    let manager :AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
    let YourApiKey = "f8tmzfkbvdb5za7hzaw7dn98"
    let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=" + YourApiKey
    let request = NSMutableURLRequest(URL: NSURL.URLWithString(RottenTomatoesURLString))

    let requestSuccess = {
        (operation :AFHTTPRequestOperation!, responseObject :AnyObject!) -> Void in
        NSLog("JSON: " + responseObject.description)
        let dictionary =  responseObject as NSDictionary
        self.moviesArray = dictionary["movies"] as? NSArray
        SVProgressHUD.dismiss()
        self.pullToRefreshControll.endRefreshing();
        self.movieTableView.reloadData()

    }
    let requestFailure = {
        
        (operation :AFHTTPRequestOperation!, error :NSError!) -> Void in
        SVProgressHUD.dismiss()
        NSLog("requestFailure: \(error)")
    }
    
    SVProgressHUD.show()
    manager.GET(RottenTomatoesURLString, parameters: nil, success: requestSuccess, failure: requestFailure)
    
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if moviesArray != nil {
            return moviesArray!.count
        }
        return 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell  = movieTableView.dequeueReusableCellWithIdentifier("com.codepath.rottentomatoes.moviecell") as MoviewTableViewCell
        let movieDictionary = self.moviesArray![indexPath.row] as NSDictionary
            cell.titleLabel?.text = movieDictionary["title"] as NSString
        let posterDictionary = movieDictionary["posters"]  as NSDictionary
        let photoUrlRequest : NSURLRequest = NSURLRequest(URL: NSURL.URLWithString(posterDictionary["thumbnail"] as NSString))
        
        let imageRequestSuccess = {
            (request : NSURLRequest!, response : NSHTTPURLResponse!, image : UIImage!) -> Void in
            cell.titleThumbnail.image = image;
            cell.titleThumbnail.alpha = 0
            UIView.animateWithDuration(0.2, animations: {
                cell.titleThumbnail.alpha = 1.0
            })
        }
        let imageRequestFailure = {
            (request : NSURLRequest!, response : NSHTTPURLResponse!, error : NSError!) -> Void in
            NSLog("imageRequrestFailure")
        }
        cell.titleThumbnail.setImageWithURLRequest(photoUrlRequest, placeholderImage: nil, success: imageRequestSuccess, failure: imageRequestFailure)

        return cell
    }
    

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetails"{
            var movieDetailsController = segue.destinationViewController as MovieDetailsViewController
            let movie = self.moviesArray![self.movieTableView.indexPathForSelectedRow()!.row] as NSDictionary
            movieDetailsController.movieDetail = movie
        }
    }
}

