//
//  ViewController.swift
//  DCTheMovie
//
//  Created by Daniel Colnaghi on 19/04/17.
//  Copyright © 2017 Cold Mass Digital Entertainment. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

	var moviesVM : MoviesViewModel = MoviesViewModel()
	var selectedItem : Movie!
	var loadingMore : Bool = false
	
	@IBOutlet weak var tblMovies: UITableView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		moviesVM.loadMovies { () in
			self.tblMovies.reloadData()
		}
		
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return moviesVM.movies.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "moviecell") as! MovieCell
		cell.loadCellWithMovie(moviesVM.movies[indexPath.row])
		
		if (!loadingMore && indexPath.row == moviesVM.movies.count - 1) {
			moviesVM.loadMoreMovies {
				self.loadingMore = false
				self.tblMovies.reloadData()
			}
		}
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		selectedItem = moviesVM.movies[indexPath.row]
		performSegue(withIdentifier: "segueMovieDetails", sender: self)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let vc = segue.destination as! MovieDetailsViewController
		vc.viewModel = MovieDetailViewModel(movie: selectedItem)
	}
}
