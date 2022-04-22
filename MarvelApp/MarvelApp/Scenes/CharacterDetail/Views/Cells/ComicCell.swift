//
//  ComicCell.swift
//  MarvelApp
//
//  Created by GOKHAN on 21.04.2022.
//

import UIKit

final class ComicCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var imageViewComic: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    
    // MARK: - Properties
    var comic: ComicPresentation? {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - Methods
    private func updateUI() {
        guard let comic = comic else { return }
        
        imageViewComic.image(from: comic.imageUrl, placeHolder: nil)
        labelTitle.text = comic.title
        viewContent.layer.cornerRadius = 5
    }
}
