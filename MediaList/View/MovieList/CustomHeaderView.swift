//
//  CustomHeaderView.swift
//  MediaList
//
//  Created by KaiD on 07/02/2023.
//

import UIKit

class CustomHeaderView: UIView {
    @IBOutlet private weak var lastVisitedLabel: UILabel!
    
    class func viewFromNib() -> UIView {
        return UINib(nibName: "CustomHeaderView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    func setLastVisitedDate(with dateString: String) {
        self.lastVisitedLabel.text = "Last visited: \(dateString)"
    }
}
