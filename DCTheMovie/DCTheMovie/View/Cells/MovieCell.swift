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
    private var animator: UIDynamicAnimator!
    private var attachment: UIAttachmentBehavior!
    private var collision: UICollisionBehavior!
    private var dynamicItem: UIDynamicItemBehavior!
    
	func loadCellWithMovie(_ movie : Movie) {
        
        // Behaviors
        attachment = UIAttachmentBehavior(item: self.imgBackground, attachedToAnchor: CGPoint(x: vAnchor.center.x, y: vAnchor.center.y))
        gravity = UIGravityBehavior(items: [self.imgBackground])
        collision = UICollisionBehavior(items: [self.imgBackground])
        collision.translatesReferenceBoundsIntoBoundary = true
        dynamicItem = UIDynamicItemBehavior(items: [self.imgBackground])
        dynamicItem.allowsRotation = true

        animator = UIDynamicAnimator(referenceView: self)
        animator.addBehavior(dynamicItem)
        animator.addBehavior(gravity)
        animator.addBehavior(attachment)
//        animator.addBehavior(collision)
        
        
        
        
        self.lblTitle.text = movie.title
        self.lblVote.text = "Vote Avarage \(movie.voteAvarage)"
        self.lblReleaseDate.text = "\(movie.releaseDate)"
        self.movieId = movie.id
        
        if self.reuseIdentifier == "moviecell" {
            movie.loadCoverImage { (image) in
                if movie.id == self.movieId {
                    self.imgBackground.image = image
                }
            }
        }
	}
}
