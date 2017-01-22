//
//  TweetEntity+CoreDataProperties.swift
//  StanfordTwitter
//
//  Created by brendan woods on 2017-01-22.
//  Copyright © 2017 brendan woods. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension TweetEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TweetEntity> {
        return NSFetchRequest<TweetEntity>(entityName: "TweetEntity");
    }

    @NSManaged public var posted: NSDate?
    @NSManaged public var text: String?
    @NSManaged public var unique: String?
    @NSManaged public var tweeter: TwitterUserEntity?

}
