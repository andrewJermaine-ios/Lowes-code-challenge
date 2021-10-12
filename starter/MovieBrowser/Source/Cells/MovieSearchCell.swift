//
//  MovieSearchCell.swift
//  MovieBrowser
//
//  Created by Andrew on 10/11/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class MovieSearchCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    func configureCell(title: String, rating: String, date: String) {
        titleLabel.text = title
        dateLabel.text = date
        ratingLabel.text = rating
    }
}
