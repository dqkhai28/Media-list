//
//  MovieListTableViewCell.swift
//  MediaList
//
//  Created by KaiD on 04/02/2023.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {
    @IBOutlet private weak var displayView: UIView!
    @IBOutlet private weak var artWorkImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!
    
    var onTapFavorite: (()-> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = .black
        displayView.layer.cornerRadius = 10
        favoriteButton.setTitle("", for: .normal)
        favoriteButton.setImage(UIImage(named: "ic_heart_gray"), for: .normal)
        favoriteButton.setImage(UIImage(named: "ic_heart_red"), for: .selected)
        favoriteButton.backgroundColor = .clear
    }
    
    override func prepareForReuse() {
        self.titleLabel.text = ""
        self.genreLabel.text = ""
        self.priceLabel.text = ""
        self.artWorkImageView.image = nil
    }
    
    func showMovie(with data: MovieModel) {
        self.titleLabel.text = data.name
        self.genreLabel.text = data.genre
        self.priceLabel.text = data.price
        self.favoriteButton.isSelected = data.isFavorite
        self.artWorkImageView.loadImage(from: data.imageSmall)
    }
    
    @IBAction func onTapFavoriteButton(_ sender: UIButton) {
        self.onTapFavorite?()
    }
}
