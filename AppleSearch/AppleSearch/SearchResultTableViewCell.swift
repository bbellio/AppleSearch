//
//  SearchResultTableViewCell.swift
//  AppleSearch
//
//  Created by Bethany Wride on 10/3/19.
//  Copyright © 2019 Bethany Wride. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    // MARK: - Outlets
    
    var musicItem: MusicSearchResult? {
        didSet {
            updateViewsForMusicItem()
        }
    }
    
    var appItem: AppSearchResult? {
        didSet {
            updateViewsForAppItem()
        }
    }
    
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    func updateViewsForMusicItem() {
        guard let item = musicItem else { return }
        titleLabel.text = item.trackName
        subtitleLabel.text = item.artistName
        artworkImageView.image = nil
        SearchController.getMusicImageFor(item: item) { (image) in
            if let image = image {
                DispatchQueue.main.async {
                    self.artworkImageView.image = image
                }
            } else {
                print("Image was nil")
            }
        }
    }
    
    func updateViewsForAppItem() {
        guard let item = appItem else { return }
        titleLabel.text = item.trackName
        subtitleLabel.text = item.description
        artworkImageView.image = nil
        SearchController.getAppImageFor(item: item) { (image) in
            if let image = image {
                DispatchQueue.main.async {
                    self.artworkImageView.image = image
                }
            } else {
                print("Image was nil")
            }
        }
    }
}
