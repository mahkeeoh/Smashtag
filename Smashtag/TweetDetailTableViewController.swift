//
//  TweetDetailTableViewController.swift
//  Smashtag
//
//  Created by Mikael Olezeski on 11/2/17.
//  Copyright © 2017 Stanford University. All rights reserved.
//

import UIKit
import Twitter

class TweetDetailTableViewController: UITableViewController {
    
    // Model

    var tweet: Twitter.Tweet? {
        didSet {
          //  var imageSection = DetailSection(media: [], sectionName: SectionNames.image)
            if let images = tweet?.media {
                let imageSection = DetailSection(media: images.map{MediaType.image($0.url, $0.aspectRatio)}, sectionName: SectionNames.image)
                detailMentions.append(imageSection)
            }
            if let hashtags = tweet?.hashtags {
                let hashtagSection = DetailSection(media: hashtags.map{MediaType.mention($0.keyword)}, sectionName: SectionNames.hashtag)
                detailMentions.append(hashtagSection)
            }
            if let users = tweet?.userMentions {
                let userSection = DetailSection(media: users.map{MediaType.mention($0.keyword)}, sectionName: SectionNames.user)
                detailMentions.append(userSection)
            }
            if let urls = tweet?.urls {
                let urlSection = DetailSection(media: urls.map{MediaType.mention($0.keyword)}, sectionName: SectionNames.url)
                detailMentions.append(urlSection)
            }
        }
    }
    
    private var detailMentions = [DetailSection]()
    
    private struct DetailSection {
        var media: [MediaType]?
        var sectionName: String
    }
    
    private enum MediaType {
        case mention(String)
        case image (URL, Double)
    }
    
    private struct SectionNames {
        static let image = "Images"
        static let hashtag = "Hashtags"
        static let user = "Users"
        static let url = "URLs"
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return detailMentions.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailMentions[section].media!.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return detailMentions[section].sectionName
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch detailMentions[indexPath.section].media![indexPath.row] {
        case .mention(_):
            return UITableViewAutomaticDimension
        
        case .image(_, let aspectRatio):
            return (tableView.frame.size.width / CGFloat(aspectRatio))
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> TweetDetailTableViewCell {
        
        var cell: TweetDetailTableViewCell
    
        switch detailMentions[indexPath.section].media![indexPath.row] {
        case let .mention( mentionKeyword):
            cell = tableView.dequeueReusableCell(withIdentifier: "mentionCell", for: indexPath) as! TweetDetailTableViewCell
            cell.textLabel?.text = mentionKeyword
        case let .image( url,  aspectRatio):
            cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! TweetDetailTableViewCell
            cell.aspectRatio = aspectRatio
            cell.imageURL = url
        }
        

        return cell
    }
    



    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller
    }

}
