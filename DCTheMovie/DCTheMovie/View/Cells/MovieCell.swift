//
//  MovieCell.swift
//  DCTheMovie
//
//  Created by Daniel Colnaghi on 4/23/17.
//  Copyright © 2017 Cold Mass Digital Entertainment. All rights reserved.
//

import UIKit

class MovieCell : UITableViewCell {

	@IBOutlet weak var imgBackground: UIImageView!
	@IBOutlet weak var lblTitle: UILabel!
	@IBOutlet weak var lblVote: UILabel!
	@IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var vAnchor: UIView!
    
    private var movieId = 0
    
    // Dynamics
    private var gravity: UIGravityBehavior!
    private var animator: UIDynamicAnimator?
    private var attachment: UIAttachmentBehavior!
    private var dynamicItem: UIDynamicItemBehavior!
    private var push: UIPushBehavior!
    
    var movie: Movie! {
        didSet {
            loadCell()
        }
    }
    
	private func loadCell() {
        
        animateImage()
        
        self.lblTitle.text = movie.title
        
        if let vote = movie.voteAvarage {
            self.lblVote.text = "Vote Avarage \(vote)"
        } else {
            self.lblVote.text = "Vote Avarage -"
        }
        self.lblReleaseDate.text = "\(movie.releaseDate)"
        self.movieId = movie.id
        
        if self.reuseIdentifier == "moviecell" {
            movie.loadCoverImage { (image) in
                if self.movie.id == self.movieId {
                    self.imgBackground.image = image
                }
            }
        }
	}
    
    private func animateImage() {
        // Behaviors
        attachment = UIAttachmentBehavior(item: self.imgBackground, offsetFromCenter: UIOffset(horizontal: 2, vertical: -40), attachedToAnchor: vAnchor.center)
        
        push = UIPushBehavior(items: [self.imgBackground], mode: .instantaneous)
        push.angle = 0.5
        push.magnitude = 0.15
        
        gravity = UIGravityBehavior(items: [self.imgBackground])
        
        dynamicItem = UIDynamicItemBehavior(items: [self.imgBackground])
        dynamicItem.allowsRotation = true
        dynamicItem.elasticity = 0
        dynamicItem.resistance = 1
        
        // Animator
        animator = UIDynamicAnimator(referenceView: self)
        animator?.addBehavior(dynamicItem)
        animator?.addBehavior(gravity)
        animator?.addBehavior(attachment)
        animator?.addBehavior(push)
    }
    
    deinit {
        animator?.removeAllBehaviors()
    }
}
