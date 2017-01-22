//
//  TweetTableViewCell.swift
//  StanfordTwitter
//
//  Created by brendan woods on 2017-01-19.
//  Copyright © 2017 brendan woods. All rights reserved.
//

import UIKit
import Twitter

class TweetTableViewCell: UITableViewCell
{

    @IBOutlet weak var tweetProfileImageView: UIImageView!
    

    @IBOutlet weak var tweetCreatedLabel: UILabel!

    @IBOutlet weak var tweetScreenameLabel: UILabel!

    
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    
    var tweet:Twitter.Tweet? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        
        // reset any tweet info
        tweetTextLabel?.attributedText = nil
        tweetScreenameLabel?.text = nil
        tweetProfileImageView?.image = nil
        tweetCreatedLabel?.text = nil
        
        //load new info from tweet (if any)
        if let tweet = self.tweet {
            tweetTextLabel?.text = tweet.text
            if tweetTextLabel?.text != nil {
                for _ in tweet.media {
                    tweetTextLabel.text! += "☕️"
                }
            }
            
            //THIS COULD BE WRONG
            tweetScreenameLabel?.text = tweet.user.name
            
            if let tweetProfileImageURL = tweet.user.profileImageURL {
                if let imageData = NSData(contentsOf: tweetProfileImageURL as URL) {
                    //THIS BLOCKS MAIN THREAD
                    
                    tweetProfileImageView?.image = UIImage(data: imageData as Data)
                }
            }
            
            
            
            let formatter = DateFormatter()
            if NSDate().timeIntervalSince(tweet.created as Date) > 24*60*60 {
                formatter.dateStyle = DateFormatter.Style.short
            } else {
                formatter.timeStyle = DateFormatter.Style.short
            }
            tweetCreatedLabel?.text = formatter.string(from: tweet.created as Date)
            
        }
        
    }
}
