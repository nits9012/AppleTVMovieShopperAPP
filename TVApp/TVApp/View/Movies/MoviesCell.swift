//
//  MoviesCell.swift
//  TVApp
//
//  Created by Nitin Bhatt on 4/27/22.
//

import Foundation
import UIKit

class MoviesCell:UICollectionViewCell{
    
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    
    class var identifier:String{return String(describing: self)}
    class var nib:UINib{return UINib(nibName: identifier, bundle: nil)}
    
    @IBOutlet var unfocusedConstraint: NSLayoutConstraint!
    
    var focusedConstraint: NSLayoutConstraint!
    
    
    var cellViewModel:MovieCellViewModel? {
        didSet{
            DispatchQueue.main.async{
                self.newsTitle.text = self.cellViewModel?.name
                let url = URL(string: self.cellViewModel?.thumnailUrl ?? "")
                let data = try? Data(contentsOf: url!)
                self.newsImage.image = UIImage(data: data!)
            }
            
        }
    }
    

    override func awakeFromNib() {
        focusedConstraint = newsTitle.topAnchor.constraint(equalTo: newsImage.focusedFrameGuide.bottomAnchor, constant: 15)
    }

    override func updateConstraints() {
        super.updateConstraints()

        focusedConstraint.isActive = isFocused
        unfocusedConstraint.isActive = !isFocused
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)
        setNeedsUpdateConstraints()

        coordinator.addCoordinatedAnimations({
            self.layoutIfNeeded()
        })
    }
}
