//
//  CharacterDetailViewController.swift
//  MarvelApp
//
//  Created by GOKHAN on 21.04.2022.
//

import UIKit

final class CharacterDetailViewController: BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var labelName: UILabel!
    @IBOutlet private weak var labelDesc: UILabel!
    @IBOutlet private weak var imageViewCharacter: UIImageView!
    @IBOutlet private weak var collectionViewComic: UICollectionView!
    
    // MARK: - Properties
    /// View Models
    var viewModel: CharacterDetailViewModelProtocol? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    /// Variables
    var comicList: [ComicPresentation] = []
    private let cellHeight: CGFloat = 250
    private let cellWidth: CGFloat = 200
    
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.load()
        viewModel?.loadComics()
        setupCollectionView()
    }
    
    // MARK: - Methods
    private func setupCollectionView() {
        collectionViewComic.delegate = self
        collectionViewComic.dataSource = self
        collectionViewComic.registerNib(ComicCell.self)
        collectionViewComic.collectionViewLayout.invalidateLayout()
        setCollectionViewLayout()
    }
    
    private func setCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionViewComic.setCollectionViewLayout(layout, animated: true)
    }
    
    private func updateUI(_ presentation: CharacterDetailPresentation) {
        labelName.text = presentation.name
        labelDesc.text = presentation.detail
        imageViewCharacter.image(from: presentation.imageUrl, placeHolder: nil)
    }
}

// MARK: - CharacterDetailViewModelDelegate
extension CharacterDetailViewController: CharacterDetailViewModelDelegate {
    func handleViewModelOutput(_ output: CharacterDetailViewModelOutput) {
        switch output {
        case .updateTitle(let title):
            self.title = title
        case .setLoading(let isLoading):
            print("isLoading \(isLoading)")
        case .showCharacterDetail(let presentation):
            updateUI(presentation)
        case .showComicList(let comicsPresentationList):
            comicList = comicsPresentationList
            collectionViewComic.reloadData()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension CharacterDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comicList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(ComicCell.self, for: indexPath)
        cell.comic = comicList[indexPath.row]
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CharacterDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

