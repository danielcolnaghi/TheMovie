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
	var loadingMore: Bool = false
    private var loadingPlaceholder = true
	
	@IBOutlet weak var tblMovies: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesVM.delegate = self
        
        fillTableUsingPlaceholder {
            self.moviesVM.loadMovies { () in
                self.loadingPlaceholder = false
                self.tblMovies.reloadData()
            }
        }
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MovieDetailsViewController {
            if let sender = sender as? Movie {
                vc.movieDetailVM = MovieDetailViewModel(movie: sender)
            }
        }
	}
    
    func fillTableUsingPlaceholder(done:@escaping () -> Void) {
        tblMovies.reloadData()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
            done()
        }
    }
}

extension MovieViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search()
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.showsCancelButton = false
        search()
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func search() {
        if let t = searchBar.text, !t.isEmpty {
            moviesVM.params.type = "search"
            moviesVM.params.query = t
        } else {
            moviesVM.params.type = "discover"
            moviesVM.params.query = ""
        }
        
        moviesVM.params.page = 1
        
        self.loadingPlaceholder = true
        self.moviesVM.removeAllMovies()
        fillTableUsingPlaceholder {
            self.moviesVM.loadMovies { () in
                self.loadingPlaceholder = false
                self.tblMovies.reloadData()
            }
        }
    }
}

extension MovieViewController: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return loadingPlaceholder ? 5 : moviesVM.countMovies()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : MovieCell!
        
        if loadingPlaceholder {
            // Placehold cell
            cell = tableView.dequeueReusableCell(withIdentifier: "moviecellplaceholder") as! MovieCell
        } else {
            // Movie cell
            cell = tableView.dequeueReusableCell(withIdentifier: "moviecell") as! MovieCell
            cell.loadCellWithMovie(moviesVM.movieAtIndex(indexPath.row)!)
            // MoviesViewModel will try to call another page when the last index cell is called
            // This will send a response when done
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if loadingPlaceholder {
            tableView.deselectRow(at: indexPath, animated: false)
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
            let data = moviesVM.movieAtIndex(indexPath.row)
            performSegue(withIdentifier: "segueMovieDetails", sender: data)
        }
    }
}

// This response is called after the page request
extension MovieViewController: AsyncResponse {
    func doneLoadMoreMovies() {
        self.tblMovies.reloadData()
    }
}
