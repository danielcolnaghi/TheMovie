//
//  WatchedMoviesViewController.swift
//  DCTheMovie
//
//  Created by Daniel Colnaghi on 22/06/18.
//  Copyright © 2018 Cold Mass Digital Entertainment. All rights reserved.
//

import UIKit

class WatchedMoviesViewController: UIViewController {

    var myMoviesVM = WatchedMoviesViewModel()
    @IBOutlet weak var tblMovies: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myMoviesVM.reloadData()
        tblMovies.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MovieDetailsViewController {
            if let sender = sender as? Movie {
                vc.movieDetailVM = MovieDetailViewModel(movie: sender)
            }
        }
    }
}

extension WatchedMoviesViewController: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myMoviesVM.countMovies
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "moviecell") as? MyMovieCell else {
            return UITableViewCell()
        }
        
        cell.loadCellWithMovie(myMoviesVM.movieAtIndex(indexPath.row)!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let data = myMoviesVM.movieAtIndex(indexPath.row)
        performSegue(withIdentifier: "watchedMoviesSegue", sender: data)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAct = UITableViewRowAction(style: .destructive, title: "Remove") { (rowAction, index) in
            if let movie = self.myMoviesVM.movieAtIndex(indexPath.row) {
                // Remove movie from watched list
                self.myMoviesVM.removeMovie(movie)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }

        return [deleteAct]
    }
}
