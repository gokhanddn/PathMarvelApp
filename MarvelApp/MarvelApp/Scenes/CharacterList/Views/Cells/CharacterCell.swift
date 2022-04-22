//
//  CharacterCell.swift
//  MarvelApp
//
//  Created by GOKHAN on 21.04.2022.
//

import UIKit

final class CharacterCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgCharacter: UIImageView!
    
    // MARK: - Properties
    var character: CharacterPresentation? {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - Methods
    private func updateUI() {
        guard let character = character else { return }
        
        lblName.text = character.name
        imgCharacter.image(from: character.imageUrl, placeHolder: nil)
    }
}
