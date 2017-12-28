//
//  Mention.swift
//  Smashtag
//
//  Created by Mikael Olezeski on 12/18/17.
//  Copyright © 2017 Stanford University. All rights reserved.
//

import UIKit
import CoreData
import Twitter

class Mention: NSManagedObject {
    
    
    class func findOrCreateMention(matching twitterInfo: Twitter.Tweet, for searchText: String, with keyword: String, in context: NSManagedObjectContext) throws -> Mention {
        let mentionRequest: NSFetchRequest<Mention> = Mention.fetchRequest()
        
        mentionRequest.predicate = NSPredicate(format: "title = %@ && searchTerm = %@ ", keyword.lowercased() , searchText)
        
        do {
            let matches = try context.fetch(mentionRequest)
            if matches.count > 0 {
                assert(matches.count == 1, "Mention.findOrCreateMention -- database inconsistency")
                if let tweet = Tweet.findOrCreateTweet(matching: twitterInfo, with: matches[0], for: searchText, in: context) {
                    matches[0].addToTweet(tweet)
                    matches[0].count += 1
                }
                return matches[0]
            }
        } catch {
            throw error
        }
        
        let mention = Mention(context: context)
        mention.searchTerm = searchText
        mention.title = keyword.lowercased()
        if let tweet = Tweet.findOrCreateTweet(matching: twitterInfo, with: mention, for: searchText, in: context) {
            mention.addToTweet(tweet)
        }
        return mention
    }
}
