//
//  UIImageExtension.swift
//  MediaList
//
//  Created by KaiD on 05/02/2023.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

extension UIImageView {
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        let placeholderImage = UIImage(named: "ic_no_image")
        
        af.setImage(withURL: url, placeholderImage: placeholderImage)
    }
}
