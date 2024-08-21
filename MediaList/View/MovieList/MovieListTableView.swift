//
//  MovieListTableView.swift
//  MediaList
//
//  Created by KaiD on 04/02/2023.
//

import Foundation
import UIKit

class MovieListTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    private var data: [MovieModel] = []
    private let customRefreshControl = UIRefreshControl()
    
    var rootViewController: UIViewController?
    var onTapFavorite: ((_ index: Int)->Void)?
    var onPullToRefresh: (()->Void)?
    
    private func setupRefreshControl() {
        customRefreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        customRefreshControl.tintColor = .white
    }
    
    func setupTableView(with data: [MovieModel]) {
        self.setupRefreshControl()
        self.delegate = self
        self.dataSource = self
        self.register(UINib(nibName: "MovieListTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieListTableViewCell")
        self.data = data
        self.backgroundColor = .black
        self.separatorStyle = .none
        self.refreshControl = customRefreshControl
        
        if #available(iOS 15.0, *) {
            self.sectionHeaderTopPadding = 0
        }
    }
    
    func reload(with newData: [MovieModel]) {
        self.refreshControl?.endRefreshing()
        self.data = newData
        self.reloadData()
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
        cell.onTapFavorite = { [weak self] in
            guard let self = self else {
                return
            }
            
            self.onTapFavorite?(indexPath.row)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovieData = data[indexPath.row]
        let movieDetailsViewController = MovieDetailsViewController(nibName: "MovieDetailsViewController", bundle: nil)
        movieDetailsViewController.movieDetailsData = selectedMovieData
        self.rootViewController?.navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let lastVisitedDate = UserDefaults.standard.string(forKey: Constant.lastVisitedDateKey) {
            guard let customView = CustomHeaderView.viewFromNib() as? CustomHeaderView else {
                return nil
            }
            customView.setLastVisitedDate(with: lastVisitedDate)
            return customView
        } else {
            return nil
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let _ = UserDefaults.standard.string(forKey: Constant.lastVisitedDateKey) {
            guard let customView = CustomHeaderView.viewFromNib() as? CustomHeaderView else {
                return 0
            }
            return customView.bounds.height
        } else {
            return 0
        }
    }
    
    @objc private func refreshData(_ sender: Any) {
        self.onPullToRefresh?()
    }
}
