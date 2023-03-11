//
//  TitleCollectionViewCell.swift
//  MoviesClone
//
//  Created by mona alshiakh on 27/07/1444 AH.
//

import UIKit
import SDWebImage

class TitleCollectionViewCell: UICollectionViewCell {
    // this title will handel every thing instade of thr orignal collction view cell
    static let identifier = "TitleCollectionViewCell"
    
    private let posterImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    // adding 3th party library called sdwebimage that will help to retrive the poster image from TMDB without coco toutch
    public func configure(with model: String){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model)") else {return}
        posterImageView.sd_setImage(with: url, completed: nil)
        
    }
}
