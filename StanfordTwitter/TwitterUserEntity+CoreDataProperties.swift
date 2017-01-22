//
//  TwitterUserEntity+CoreDataProperties.swift
//  StanfordTwitter
//
//  Created by brendan woods on 2017-01-22.
//  Copyright © 2017 brendan woods. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension TwitterUserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TwitterUserEntity> {
        return NSFetchRequest<TwitterUserEntity>(entityName: "TwitterUserEntity");
    }

    @NSManaged public var screenName: String?
    @NSManaged public var tweets: NSSet?

}

// MARK: Generated accessors for tweets
extension TwitterUserEntity {

    @objc(addTweetsObject:)
    @NSManaged public func addToTweets(_ value: TweetEntity)

    @objc(removeTweetsObject:)
    @NSManaged public func removeFromTweets(_ value: TweetEntity)

    @objc(addTweets:)
    @NSManaged public func addToTweets(_ values: NSSet)

    @objc(removeTweets:)
    @NSManaged public func removeFromTweets(_ values: NSSet)

}
