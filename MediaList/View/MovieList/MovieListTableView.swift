//
//  MovieListTableView.swift
//  MediaList
//
//  Created by KaiD on 04/02/2023.
//

import Foundation
import UIKit

class MovieListTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    var data: [MovieModel] = [] {
        didSet {
            self.reloadData()
        }
    }
    
    var onSelectMovie: ((_ data: MovieModel)->Void)?
    
    func setupTableView(with data: [MovieModel]) {
        self.delegate = self
        self.dataSource = self
        self.register(UINib(nibName: "MovieListTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieListTableViewCell")
        self.data = data
        self.backgroundColor = .black
        self.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell", for: indexPath) as? MovieListTableViewCell else {
            return UITableViewCell()
        }
        let cellData = data[indexPath.row]

        cell.showMovie(with: cellData)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovieData = data[indexPath.row]
        self.onSelectMovie?(selectedMovieData)
    }
}
