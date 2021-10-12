//
//  SearchViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/19/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var textResult = String()
    var jsonResult: [ArrayType]?
    
    struct Movies: Codable {
        var results: [ArrayType]
    }
    struct ArrayType: Codable {
        var backdrop_path: String?
        var original_title: String?
        var vote_count: Int?
        var vote_average: Double?
        var release_date: String?
        var overview: String?
    }

    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func searchForMovieWith(text: String) {
        textResult = handleSpacesIn(text: text)
        let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=5885c445eab51c7004916b9c0313e2d3&language=en-US&query=\(textResult)&page=1&include_adult=true")!
        if let data = try? Data(contentsOf: url) {
            parse(json: data)
        }
    }
    
    func handleSpacesIn(text: String) -> String {
        textResult = text.replacingOccurrences(of: " ", with: "%20")
        return textResult
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
           if let jsonResult = try? decoder.decode(Movies.self, from: json) {
               self.jsonResult = jsonResult.results
           }
        tableView.reloadData()
    }
    
    @IBAction func goBTNPressed(_ sender: Any) {
        if let query = searchBar.text {
            searchForMovieWith(text: query)
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var num = Int()
        if let arrayCount = jsonResult?.count {
            num = arrayCount
        }
        return num
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieSearchCell") as? MovieSearchCell else { return UITableViewCell()}
        let movieInfo = jsonResult![indexPath.row]
        cell.configureCell(title: movieInfo.original_title!, rating: String(movieInfo.vote_average!), date: movieInfo.release_date!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "movieDetailVC") as? MovieDetailViewController else { return }
        let movieInfo = jsonResult![indexPath.row]
        print(movieInfo.original_title!)
        detailVC.movieTitle = movieInfo.original_title!
        detailVC.releaseDate = movieInfo.release_date!
        detailVC.image = movieInfo.backdrop_path!
        detailVC.overview = movieInfo.overview!
        present(detailVC, animated: true, completion: nil)
        
        
    }
    
    
    
    
}
