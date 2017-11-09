//
//  TweetDetailTableViewCell.swift
//  Smashtag
//
//  Created by Mikael Olezeski on 11/8/17.
//  Copyright © 2017 Stanford University. All rights reserved.
//

import UIKit

class TweetDetailTableViewCell: UITableViewCell {

    private var tweetDetailImageView: UIImageView?
    var aspectRatio: Double?
    var imageURL: URL? {
        didSet {
            updateUI()
        }
    }
    
    
    private func updateUI() {
        if let imageData = try? Data(contentsOf: imageURL!) {
            DispatchQueue.main.async { [weak self] in
                self?.tweetDetailImageView = UIImageView()
                self?.tweetDetailImageView?.frame = CGRect(x: 0, y: 0, width: (self?.frame.size.width)!, height: ((self?.frame.size.width)! / CGFloat((self?.aspectRatio!)!)))
                self?.tweetDetailImageView?.image = UIImage(data: imageData)
                self?.addSubview((self?.tweetDetailImageView)!)
            }
            
        }
    }

    

}
