//
//  MovieDetailsViewController.swift
//  DCTheMovie
//
//  Created by Daniel Colnaghi on 4/22/17.
//  Copyright © 2017 Cold Mass Digital Entertainment. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet var imgFull: UIImageView?
    @IBOutlet var tblMovieDetails: UITableView?
    @IBOutlet var btnAddMovie: UIBarButtonItem!
    var addMovieSelectedColor: UIColor!
    
    var movieDetailVM : MovieDetailViewModel!
    private var myMoviesVM = MyMoviesViewModel()
    private var whatchedMoviesVM = WatchedMoviesViewModel()
    
    var cellIdList : [String]!
    
	override func viewDidLoad() {
		super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        cellIdList = ["movieBackdropCell","movieTitleCell","movieDetailsCell","movieOverviewCell"]
        
        // Store default value
        addMovieSelectedColor = btnAddMovie.tintColor
        btnAddMovie.tintColor = nil
        
        if myMoviesVM.hasMovie(movieDetailVM.movie) || whatchedMoviesVM.hasMovie(movieDetailVM.movie) {
            btnAddMovie.isEnabled = false
        }
        
        movieDetailVM.loadDetails {
            self.tblMovieDetails?.reloadData()
        }
        
        movieDetailVM.movie.loadBackdropImage(success: { (image) in
            self.imgFull?.image = image
        })
	}
    
    @IBAction func addMovie(_ sender: Any) {
        
        if myMoviesVM.hasMovie(movieDetailVM.movie) {
            myMoviesVM.removeMovie(movieDetailVM.movie)
            btnAddMovie.tintColor = nil
        } else {
            myMoviesVM.addMovie(movieDetailVM.movie)
            btnAddMovie.tintColor = addMovieSelectedColor
        }
    }
}

extension MovieDetailsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdList[indexPath.row]) else {
            return UITableViewCell()
        }
        
        if var c = cell as? MovieCellBase {
            c.model = movieDetailVM.movie
        }
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellIdList.count
    }
}

