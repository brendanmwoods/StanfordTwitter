//
//  TweetEntity2+CoreDataProperties.swift
//  StanfordTwitter
//
//  Created by brendan woods on 2017-01-22.
//  Copyright © 2017 brendan woods. All rights reserved.
//

import Foundation
import CoreData


extension TweetEntity2 {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TweetEntity2> {
        return NSFetchRequest<TweetEntity2>(entityName: "TweetEntity2");
    }

    @NSManaged public var posted: NSDate?
    @NSManaged public var text: String?
    @NSManaged public var unique: String?
    @NSManaged public var tweeter: TwitterUserEntity2?

}
