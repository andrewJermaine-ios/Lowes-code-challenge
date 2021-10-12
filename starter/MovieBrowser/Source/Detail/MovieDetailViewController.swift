//
//  MovieDetailViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/26/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    var movieTitle: String?
    var releaseDate: String?
    var image: String?
    var overview: String?
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var infoTextBox: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        movieTitleLabel.text = movieTitle
        dateLabel.text = "Release date: \(releaseDate!)"
        infoTextBox.text = overview
        handleImage(string: image!)
        print(image!)
    }
    
    func handleImage(string: String) {
        let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(string)")!
        imageView.load(url: imageURL)
        print(imageURL)
    }
    
    
    @IBAction func backBTNPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
