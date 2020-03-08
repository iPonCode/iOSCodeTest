//  PopularMovieCell.swift
//  iOSCodeTest
//
//  Created by Simón Aparicio on 07/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import UIKit

// TODO: Creat the XIB for cell
// TODO: The cell protocol for actions to pass data from cell to ViewController if needed

protocol PopularMovieCell {
    func configure(id: Int, title: String, posterPath: String, releaseDate: String)
}

class PopularMovieCellImpl: UITableViewCell, PopularMovieCell {
    
    // TODO: @IBOulet labels and image
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    
    
    // This occurs when the xib is ready
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = .white
    }
    
    func configure(id: Int, title: String, posterPath: String, releaseDate: String) {
        
        // TODO: asign values to labels and images
        idLabel.text = String(id)
        titleLabel.text = title
        releaseDateLabel.text = releaseDate
        
        // TODO: retrieve image from url
    }
    
}

