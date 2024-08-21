//
//  BaseViewController.swift
//  MediaList
//
//  Created by KaiD on 06/02/2023.
//

import Foundation
import UIKit
import RealmSwift

class BaseViewController: UIViewController {
    public func addMovieToRealmDB(movie: MovieModel) {
        let realmObject = movie.getRealmModel()
        if let error = RealmManager.shared.addObject(object: realmObject) {
            print(error)
        }
    }
    
    public func deleteMovieFromRealmDB(movieID: Int) {
        if let objectToDelete: RealmMovieModel = RealmManager.shared.getObjects(id: movieID).first {
            if let error = RealmManager.shared.deleteObject(object: objectToDelete) {
                print(error)
            }
        }
    }
    
    public func setupSearchBar() -> UISearchController {
        let searchController = UISearchController(searchResultsController: nil)
        
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.searchBarStyle = .default
        searchController.searchBar.placeholder = "Search Movie"
        
        searchController.searchBar.searchTextField.layer.cornerRadius = 18
        searchController.searchBar.searchTextField.layer.masksToBounds = true
        
        searchController.searchBar.backgroundColor = .clear
        searchController.searchBar.searchTextField.leftView?.tintColor = .white
        searchController.searchBar.searchTextField.backgroundColor = .darkGray
        
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.definesPresentationContext = true
        
        return searchController
    }
}
