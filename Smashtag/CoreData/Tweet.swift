//
//  Tweet.swift
//  Smashtag
//
//  Created by Mikael Olezeski on 12/18/17.
//  Copyright © 2017 Stanford University. All rights reserved.
//

import UIKit
import Twitter
import CoreData

class Tweet: NSManagedObject {
    
    class func findOrCreateTweet(matching twitterInfo: Twitter.Tweet, with mention: Mention, for searchText: String, in context: NSManagedObjectContext)  -> Tweet? {
        let request: NSFetchRequest<Tweet> = Tweet.fetchRequest()
        request.predicate = NSPredicate(format: "unique = %@ && mention = %@ && mention.searchTerm = %@", twitterInfo.identifier, mention, searchText)
        if let tweet = try? context.fetch(request) {
            if tweet.count > 0 {
                return nil
            }
        }
        
        let tweet = Tweet(context: context)
        tweet.unique = twitterInfo.identifier
        return tweet
    }
}
