//
//  TwitterUserEntity2+CoreDataProperties.swift
//  StanfordTwitter
//
//  Created by brendan woods on 2017-01-22.
//  Copyright © 2017 brendan woods. All rights reserved.
//

import Foundation
import CoreData


extension TwitterUserEntity2 {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TwitterUserEntity2> {
        return NSFetchRequest<TwitterUserEntity2>(entityName: "TwitterUserEntity2");
    }

    @NSManaged public var screenName: String?
    @NSManaged public var tweets: NSSet?

}

// MARK: Generated accessors for tweets
extension TwitterUserEntity2 {

    @objc(addTweetsObject:)
    @NSManaged public func addToTweets(_ value: TweetEntity2)

    @objc(removeTweetsObject:)
    @NSManaged public func removeFromTweets(_ value: TweetEntity2)

    @objc(addTweets:)
    @NSManaged public func addToTweets(_ values: NSSet)

    @objc(removeTweets:)
    @NSManaged public func removeFromTweets(_ values: NSSet)

}
