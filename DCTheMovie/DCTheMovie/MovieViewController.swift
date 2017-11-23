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
        
        self.moviesVM.removeAllMovies()
        self.moviesVM.loadMovies { () in
            self.tblMovies.reloadData()
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
            cell = tableView.dequeueReusableCell(withIdentifier: "moviecellplaceholder") as! MovieCell
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "moviecell") as! MovieCell
            cell.loadCellWithMovie(moviesVM.movieAtIndex(indexPath.row)!)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if loadingPlaceholder {
            tableView.deselectRow(at: indexPath, animated: false)
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
            selectedItem = moviesVM.movieAtIndex(indexPath.row)
            performSegue(withIdentifier: "segueMovieDetails", sender: self)
        }
    }
}

extension MovieViewController: AsyncResponse {
    func doneLoadMoreMovies() {
        self.tblMovies.reloadData()
    }
}
