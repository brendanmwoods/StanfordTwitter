//
//  TweetEntity2+CoreDataClass.swift
//  StanfordTwitter
//
//  Created by brendan woods on 2017-01-22.
//  Copyright © 2017 brendan woods. All rights reserved.
//

import Foundation
import CoreData
import Twitter


@objc(TweetEntity2)
public class TweetEntity2: NSManagedObject {
    
    class func tweetWithTwitterInfo(twitterInfo: Twitter.Tweet, inManagedObjectContext context: NSManagedObjectContext) -> TweetEntity2?
    {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TweetEntity2")
        
        request.predicate = NSPredicate(format: "unique = %@", twitterInfo.id!)
        
        if let tweet = (try? context.fetch(request))?.first as? TweetEntity2 {
            return tweet
        } else if let tweet = NSEntityDescription.insertNewObject(forEntityName: "TweetEntity2", into: context) as? TweetEntity2 {
            tweet.unique = twitterInfo.id
            tweet.text = twitterInfo.text
            tweet.posted = twitterInfo.created
            tweet.tweeter = TwitterUserEntity2.twitterUserWithTwitterInfo(twitterInfo: twitterInfo.user, inManagedObjectContext: context)
            return tweet
        }
        
        
        return nil
    }

}

