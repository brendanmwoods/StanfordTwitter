//
//  TwitterUserEntity2+CoreDataClass.swift
//  StanfordTwitter
//
//  Created by brendan woods on 2017-01-22.
//  Copyright © 2017 brendan woods. All rights reserved.
//

import Foundation
import CoreData
import Twitter

@objc(TwitterUserEntity2)
public class TwitterUserEntity2: NSManagedObject {

    class func twitterUserWithTwitterInfo(twitterInfo: Twitter.User, inManagedObjectContext context:NSManagedObjectContext) -> TwitterUserEntity2?
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TwitterUserEntity2")
        request.predicate  = NSPredicate(format: "screenName = %@", twitterInfo.screenName)
        if let twitterUser = (try? context.fetch(request))?.first as? TwitterUserEntity2 {
            return twitterUser
        } else if let twitterUser =
            NSEntityDescription.insertNewObject(forEntityName: "TwitterUserEntity2", into: context) as? TwitterUserEntity2 {
            twitterUser.screenName = twitterInfo.screenName
            return twitterUser
        }
        return nil
    }
}
