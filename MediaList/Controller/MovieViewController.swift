//
//  MovieViewController.swift
//  MediaList
//
//  Created by KaiD on 04/02/2023.
//

import UIKit

class MovieViewController: UIViewController {
    
//    private var movieListTableView: MovieListTableView!
    @IBOutlet weak var movieListTableView: MovieListTableView!
    private var movieListModel = [MovieModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchData()
        // Do any additional setup after loading the view.
    }

    private func fetchData() {
        APIRequest.shared.request(.initialize) { response in
            guard let responseData: InitializeAPIResponse = response.dataAs() else {
                return
            }
            
            guard let resultData = responseData.results else {
                return
            }
            
            self.movieListModel = resultData.map({
                return MovieModel(apiModel: $0)
            })
            
            self.setupTableView()
            print("------ Get data successfully ------")
            
        }
    }
    
    private func setupTableView() {
        self.movieListTableView.setupTableView(with: self.movieListModel)
        self.movieListTableView.onSelectMovie = { [weak self] selectedMovie in
            guard let self = self else {
                return
            }
            
            let movieDetails = MovieDetailsViewController(nibName: "MovieDetailsViewController", bundle: nil)
            self.navigationController?.pushViewController(movieDetails, animated: true)
        }
    }
}
