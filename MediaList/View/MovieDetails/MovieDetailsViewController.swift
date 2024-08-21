//
//  MovieDetailsViewController.swift
//  MediaList
//
//  Created by KaiD on 04/02/2023.
//

import UIKit

class MovieDetailsViewController: BaseViewController {
    @IBOutlet private weak var artworkImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!
    
    var movieDetailsData: MovieModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBasicUI()
        showMovieDetails()
    }
    
    private func setupBasicUI() {
        let attributedString = NSAttributedString(string: "Add to favorite",
                                                  attributes: [.font : UIFont(name: "Helvetica", size: 11) ?? .systemFont(ofSize: 11)])
        favoriteButton.setAttributedTitle(attributedString, for: .normal)
        favoriteButton.setImage(UIImage(named: "ic_heart_red"), for: .selected)
    }

    private func showMovieDetails() {
        guard let movieData = movieDetailsData else {
            return
        }

        artworkImageView.loadImage(from: movieData.imageLarge)
        titleLabel.text = movieData.name
        descriptionLabel.text = movieData.description
        genreLabel.text = movieData.genre
        priceLabel.text = movieData.price
        favoriteButton.isSelected = movieData.isFavorite
    }

    @IBAction func onTapFavoriteButton(_ sender: UIButton) {
        sender.isSelected.toggle()
        guard let movieDetailsData = movieDetailsData else {
            return
        }
        
        if sender.isSelected {
            addMovieToRealmDB(movie: movieDetailsData)
        } else {
            deleteMovieFromRealmDB(movieID: movieDetailsData.id)
        }
    }
}
