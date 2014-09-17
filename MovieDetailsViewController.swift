//
//  MovieDetailsViewController.swift
//  RottenTomatoes
//
//  Created by Saket Agarwal on 9/16/14.
//  Copyright (c) 2014 Saket Agarwal. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    var movieDetail : NSDictionary!

        
    @IBOutlet weak var movieDetailsLabel: UILabel!
    @IBOutlet weak var movieScrollView: UIScrollView!
    @IBOutlet weak var detailImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = movieDetail["title"] as NSString
        self.movieDetailsLabel.text = makeDetailsText()
        self.movieDetailsLabel.sizeToFit()
        let moviewLabelHeight = movieDetailsLabel.bounds.size.height
        movieScrollView.contentSize = CGSize(width: UIScreen.mainScreen().bounds.size.width, height: moviewLabelHeight+250)
        NSLog("height of view is \(moviewLabelHeight)")
        loadImage()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func loadImage(){
        let posterDictionary = movieDetail["posters"]  as NSDictionary
        let photoUrlRequest : NSURLRequest = NSURLRequest(URL: NSURL.URLWithString(posterDictionary["detailed"] as NSString))
    
        let imageRequestSuccess = {
            (request : NSURLRequest!, response : NSHTTPURLResponse!, image : UIImage!) -> Void in
            self.detailImageView.image = image
            self.detailImageView.alpha = 0
            UIView.animateWithDuration(0.2, animations: {
            self.detailImageView.alpha = 1.0
        })
    }
        let imageRequestFailure = {
            (request : NSURLRequest!, response : NSHTTPURLResponse!, error : NSError!) -> Void in
            NSLog("imageRequrestFailure")
        }
        self.detailImageView.setImageWithURLRequest(photoUrlRequest, placeholderImage: nil, success: imageRequestSuccess, failure: imageRequestFailure)
        }
    
    func makeDetailsText() -> String{
        let text = movieDetail["synopsis"] as NSString
        
        return text
    }

}
