//
//  FavoriteViewController.swift
//  MediaList
//
//  Created by KaiD on 04/02/2023.
//

import UIKit

class FavoriteViewController: BaseViewController {
    @IBOutlet private weak var favoriteListTableView: MovieListTableView!
    private var favoriteListModel: [MovieModel] = []
    private var searchResultData: [MovieModel] = []
    private var searchController: UISearchController!
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getFavoriteList(completion: {
            self.setupTableView()
        })
        
        self.searchController = self.setupSearchBar()
        self.searchController.delegate = self
        self.searchController.searchResultsUpdater = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getFavoriteList(completion: {
            if let searchText = self.searchController.searchBar.text {
                self.search(with: searchText)
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.searchController.searchBar.endEditing(true)
    }
    
    deinit {
        timer?.invalidate()
    }
    
    // Get UITableView used in this ViewController
    func getTableView() -> UITableView {
        return favoriteListTableView
    }
    
    // Get list of favorite movie from Realm DB
    private func getFavoriteList(completion: (()->Void)?) {
        let storedData: [RealmMovieModel] = RealmManager.shared.getObjects()
        self.favoriteListModel = storedData.map({
            return MovieModel(realmModel: $0)
        }).sorted(by: { $0.name < $1.name })
        completion?()
    }
    
    private func setupTableView() {
        self.favoriteListTableView.rootViewController = self
        self.favoriteListTableView.setupTableView(with: self.favoriteListModel)
        
        // Setup call back when click on movie's favorite button
        self.favoriteListTableView.onTapFavorite = { [weak self] index in
            guard let self = self else {
                return
            }
            
            self.deleteMovieFromRealmDB(movieID: self.searchResultData[index].id)
            self.getFavoriteList(completion: {
                if let searchText = self.searchController.searchBar.text {
                    self.search(with: searchText)
                }
            })
        }
        
        // Handle pull to refresh
        self.favoriteListTableView.onPullToRefresh = { [weak self] in
            guard let self = self else {
                return
            }
            
            self.getFavoriteList(completion: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    if let searchText = self.searchController.searchBar.text {
                        self.search(with: searchText)
                    }
                })
            })
        }
    }
}

// MARK: - Search Controller Delegate
extension FavoriteViewController: UISearchResultsUpdating, UISearchControllerDelegate {
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
            self.searchResultData = self.favoriteListModel
        } else {
            self.searchResultData = self.favoriteListModel.filter({ $0.name.lowercased().contains(key.lowercased()) })
        }
        
        self.favoriteListTableView.reload(with: self.searchResultData)
    }
}
