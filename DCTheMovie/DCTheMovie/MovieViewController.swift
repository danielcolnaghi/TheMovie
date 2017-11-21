//
//  ViewController.swift
//  DCTheMovie
//
//  Created by Daniel Colnaghi on 19/04/17.
//  Copyright © 2017 Cold Mass Digital Entertainment. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {

	var moviesVM: MoviesViewModel = MoviesViewModel()
	var selectedItem: Movie!
	var loadingMore: Bool = false
    private var loadingPlaceholder = true
	
	@IBOutlet weak var tblMovies: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillTableUsingPlaceholder {
            self.moviesVM.loadMovies { () in
                self.loadingPlaceholder = false
                self.tblMovies.reloadData()
            }
        }
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let vc = segue.destination as! MovieDetailsViewController
		vc.viewModel = MovieDetailViewModel(movie: selectedItem)
	}
    
    func fillTableUsingPlaceholder(done:@escaping () -> Void) {
        tblMovies.reloadData()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
            done()
        }
    }
}

extension MovieViewController: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return loadingPlaceholder ? 5 : moviesVM.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : MovieCell!
        
        if loadingPlaceholder {
            cell = tableView.dequeueReusableCell(withIdentifier: "moviecellplaceholder") as! MovieCell
        } else {
        
            cell = tableView.dequeueReusableCell(withIdentifier: "moviecell") as! MovieCell
            cell.loadCellWithMovie(moviesVM.movies[indexPath.row])
            
            if (!loadingMore && indexPath.row == moviesVM.movies.count - 1) {
                moviesVM.loadMoreMovies {
                    self.loadingMore = false
                    self.tblMovies.reloadData()
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if loadingPlaceholder {
            tableView.deselectRow(at: indexPath, animated: false)
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
            selectedItem = moviesVM.movies[indexPath.row]
            performSegue(withIdentifier: "segueMovieDetails", sender: self)
        }
    }
}
