//
//  ImageViewController.swift
//  Smashtag
//
//  Created by Mikael Olezeski on 11/12/17.
//  Copyright © 2017 Stanford University. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    @IBOutlet weak private var imageDetailView: UIImageView!

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    
    var detailImageURL: URL! {
        didSet {
            updateUI()
        }
    }

    private func updateUI() {
        loadingIndicator.startAnimating()
        if let imageData = try? Data(contentsOf: detailImageURL) {
            DispatchQueue.main.async { [weak self] in
            self?.image = UIImage(data: imageData)
            }
        }
    }
    
    private var image: UIImage? {
        get {
            return imageDetailView.image
        }
        set {
            imageDetailView.image = newValue
            imageDetailView.sizeToFit()
            //scrollView?.contentSize = imageView.frame.size
            loadingIndicator?.stopAnimating()
        }
    }



}
