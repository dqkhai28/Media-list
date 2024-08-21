//
//  MovieListTableViewCell.swift
//  MediaList
//
//  Created by KaiD on 04/02/2023.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {
    @IBOutlet weak var displayView: UIView!
    @IBOutlet weak var artWorkImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = .black
        displayView.layer.cornerRadius = 10
        favoriteButton.setTitle("", for: .normal)
        favoriteButton.setImage(UIImage(named: "ic_heart_gray"), for: .normal)
        favoriteButton.setImage(UIImage(named: "ic_heart_red"), for: .selected)
        favoriteButton.backgroundColor = .lightGray
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
        self.favoriteButton.isSelected = true       // Add logic later
        self.artWorkImageView.loadImage(from: data.imageSmall)
    }
}
