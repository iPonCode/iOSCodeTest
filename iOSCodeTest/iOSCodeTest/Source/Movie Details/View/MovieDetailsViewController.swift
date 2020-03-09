//  MovieDetailsViewController.swift
//  iOSCodeTest
//
//  Created by Simón Aparicio on 07/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {
    
    // TODO: Make some visual components with XIB to arrange info in Movie Details screen (use attributedText)
    // TODO: Embebed stackView into a IUScrollView (equal width constraint) to make it scrollable

    @IBOutlet weak var stackView: UIStackView!
    
    var viewModel: MovieDetailsViewModel = MovieDetailsViewModelImpl()
    var details: MovieDetails?
    var movieID: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bindViewModel()
        retrieveMovieDetails()
    }
    
    func configureView() {
        //view.backgroundColor = .systemBlue
        
        title = "Cargando.."
        stackView.spacing = 4
        stackView.distribution = .fillProportionally
    }
    
    // Create binders
    func bindViewModel() {
        
        // Start listening to this var
        viewModel.details.bind({ [weak self] (result) in
            guard let result = result else {
                return
            }
            
            // Whenever chages are made on it, will execute this code
            self?.details = result
            dump(self?.details)
            self?.updateTitle()
            self?.loadData()
        })
        
    }
    
    func retrieveMovieDetails() {
        if let movieID = movieID {
            print(movieID)
            viewModel.retrieveMovieDetails(movieID)
        }
    }
    
    func setMovieId(_ id: Int) {
        movieID = id
    }
    
    func updateTitle() {
        var titleId =  "(sin id)"
        if let stringId = details?.id {
            titleId = String(stringId)
        }
        title = "Detalles película " + String(format: "(%@)", titleId)
    }
    
    func loadData() {
        
        //title
        if let item = details?.title, !String(item).isEmpty {
            addLabelComponent(item: String(item), title: "Título")
        }
        
        //overview
        if let item = details?.overview, !String(item).isEmpty {
            addLabelComponent(item: String(item), title: "Sinopsis")
        }
        
        //image info block
        stackView.addArrangedSubview(makeImageInfoBlock())

        //tagline
        if let item = details?.tagline, !String(item).isEmpty {
            addLabelComponent(item: String(item), title: "Lema")
        }

        //originalTitle
        if let item = details?.originalTitle, !String(item).isEmpty {
            addLabelComponent(item: String(item), title: "Título Original")
        }

        //posterPath
        if let item = details?.posterPath, !String(item).isEmpty {
            addLabelComponent(item: String(item), title: "Imagen poster")
        }

        //backdropPath
        if let item = details?.backdropPath, !String(item).isEmpty {
            addLabelComponent(item: String(item), title: "Imagen fondo")
        }

        //homepage
        if let item = details?.homepage, !String(item).isEmpty {
            addLabelComponent(item: String(item), title: "Web")
        }
    }
    
    func addLabelComponent(item: String, title: String, stackView: UIStackView? = nil) {
        let itemLabel = UILabel()
        itemLabel.numberOfLines = 0
        itemLabel.text = title + ": " + item
        if stackView != nil {
            itemLabel.backgroundColor = UIColor(red: 128, green: 128, blue: 128, alpha: 0.3)
            stackView?.addArrangedSubview(itemLabel)
        } else{
            itemLabel.backgroundColor = UIColor(red: 128, green: 128, blue: 128, alpha: 0.1)
            self.stackView.addArrangedSubview(itemLabel)
        }
    }
    
    func makeImageInfoBlock() -> UIStackView {
        
        let verticalStackView: UIStackView = UIStackView()
        let horizontalStackView: UIStackView = UIStackView()
        
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fillProportionally
        verticalStackView.spacing = 4
        
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fillProportionally
        horizontalStackView.spacing = 4

        makeLeftInfoBlock(verticalStackView)
        
        // Set the default poster image if posterUrl doesn't exist
        let img = UIImage(named: "default_poster_image")
        
        let imageView: UIImageView = UIImageView(image: img)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: CGFloat(231)).isActive = true    //3 138 750
        imageView.widthAnchor.constraint(equalToConstant: CGFloat(154)).isActive = true     //2 92  500
        imageView.contentMode = .scaleToFill
        
        //posterPath
        if let path = details?.posterPath, !path.isEmpty, let url = viewModel.buildImagedUrl(path) {
            if let posterUrl = URL(string: url) {
                imageView.af.setImage(withURL: posterUrl)
            }
        }

        horizontalStackView.addArrangedSubview(verticalStackView)   // left info
        horizontalStackView.addArrangedSubview(imageView)           // right info

        return horizontalStackView
    }

    fileprivate func makeLeftInfoBlock(_ verticalStackView: UIStackView) {
        
        //adult
        if let item = details?.adult, !String(item).isEmpty {
            addLabelComponent(item: String(item), title: "Adultos", stackView: verticalStackView)
        }
        
        //status
        if let item = details?.status, !String(item).isEmpty {
            addLabelComponent(item: String(item), title: "Estado", stackView: verticalStackView)
        }
        
        //voteAverage
        if let item = details?.voteAverage, !String(item).isEmpty {
            addLabelComponent(item: String(item), title: "Promedio", stackView: verticalStackView)
        }
        
        //voteCount
        if let item = details?.voteCount, !String(item).isEmpty {
            addLabelComponent(item: String(item), title: "Votos", stackView: verticalStackView)
        }
        
        //releaseDate
        if let item = details?.releaseDate, !String(item).isEmpty {
            addLabelComponent(item: String(item), title: "Fecha", stackView: verticalStackView)
        }
        
        //imdbID
        if let item = details?.imdbID, !String(item).isEmpty {
            addLabelComponent(item: String(item), title: "IMDB", stackView: verticalStackView)
        }
        
        //popularity
        if let item = details?.popularity, !String(item).isEmpty {
            addLabelComponent(item: String(item), title: "Fama", stackView: verticalStackView)
        }
    }
    
}
