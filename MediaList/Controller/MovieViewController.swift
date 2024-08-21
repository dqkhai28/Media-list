//
//  MovieViewController.swift
//  MediaList
//
//  Created by KaiD on 04/02/2023.
//

import UIKit

class MovieViewController: BaseViewController {
    @IBOutlet private weak var movieListTableView: MovieListTableView!
    
    private var searchController: UISearchController!
    private var timer: Timer?
    private var movieListModel = [MovieModel]()
    private var searchResultData = [MovieModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchData(completion: {
            self.checkFavorite(completion: {
                self.setupTableView()
            })
        })
        self.searchController = self.setupSearchBar()
        self.searchController.delegate = self
        self.searchController.searchResultsUpdater = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.checkFavorite(completion: {
            if let searchText = self.searchController.searchBar.text {
                self.search(with: searchText)
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        searchController.searchBar.endEditing(true)
    }
    
    deinit {
        timer?.invalidate()
    }
    
    // Get UITableView used in this ViewController
    func getTableView() -> UITableView {
        return movieListTableView
    }
    
    // Get list movie data from server
    private func fetchData(completion: (()->Void)?) {
        APIRequest.shared.request(.initialize) { response in
            guard let responseData: InitializeAPIResponse = response.dataAs() else {
                return
            }
            
            guard let resultData = responseData.results else {
                return
            }
            
            self.movieListModel = resultData.map({
                return MovieModel(apiModel: $0)
            }).sorted(by: { $0.name < $1.name })
            completion?()
        }
    }
    
    private func setupTableView() {
        self.view.bringSubviewToFront(movieListTableView)
        self.movieListTableView.rootViewController = self
        self.movieListTableView.setupTableView(with: self.movieListModel)
        
        // Setup call back when click on movie's favorite button
        self.movieListTableView.onTapFavorite = { [weak self] index in
            guard let self = self else {
                return
            }
            
            let didAddToFavorite = self.searchResultData[index].isFavorite
            if didAddToFavorite {
                self.deleteMovieFromRealmDB(movieID: self.searchResultData[index].id)
            } else {
                self.addMovieToRealmDB(movie: self.searchResultData[index])
            }
            self.checkFavorite(completion: {
                if let searchText = self.searchController.searchBar.text {
                    self.search(with: searchText)
                }
            })
        }
        
        // Handle pull to refresh
        self.movieListTableView.onPullToRefresh = { [weak self] in
            guard let self = self else {
                return
            }
            
            self.fetchData(completion: {
                self.checkFavorite(completion: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                        if let searchText = self.searchController.searchBar.text {
                            self.search(with: searchText)
                        }
                    })
                })
            })
        }
    }
    
    // Update tableView data based on list of favorite movie from Realm DB
    private func checkFavorite(completion: (()->Void)?) {
        let listFavorite: [RealmMovieModel] = RealmManager.shared.getObjects()
        let listID = listFavorite.map({ $0.id })
        for (index, item) in movieListModel.enumerated() {
            if listID.contains(item.id) {
                movieListModel[index].isFavorite = true
            } else {
                movieListModel[index].isFavorite = false
            }
        }
        completion?()
    }
}

// MARK: - Search Controller Delegate
extension MovieViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = (searchController.searchBar.text ?? "")
        let delayTime = 0.5
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: delayTime, repeats: false, block: { [weak self] _ in
            print("Searching with: " + (searchController.searchBar.text ?? ""))
            self?.search(with: searchText)
        })
    }
    
    private func search(with key: String) {
        if key.isEmpty {
            self.searchResultData = self.movieListModel
        } else {
            self.searchResultData = self.movieListModel.filter({ $0.name.lowercased().contains(key.lowercased()) })
        }
        
        self.movieListTableView.reload(with: self.searchResultData)
    }
}
