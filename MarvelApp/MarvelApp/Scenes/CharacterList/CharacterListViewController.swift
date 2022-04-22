//
//  CharacterListViewController.swift
//  MarvelApp
//
//  Created by GOKHAN on 20.04.2022.
//

import UIKit

final class CharacterListViewController: BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var collectionViewCharacter: UICollectionView!
    
    // MARK: - Properties
    /// View Models
    var viewModel: CharacterListViewModelProtocol? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    /// Variables
    private var characterList: [CharacterPresentation] = []
    private var loadingView: LoadingReusableView?
    private var isLoadingMoreVisible = false
    private let space: CGFloat = 16
    private let cellHeight: CGFloat = 200
    private let loadingMoreViewHeight: CGFloat = 50
    private var currentOffset = 0
    private let limit = 30
    
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if characterList.count == 0 {
            viewModel?.load(with: currentOffset)
        }
    }
    
    // MARK: - Methods
    private func setupCollectionView() {
        collectionViewCharacter.dataSource = self
        collectionViewCharacter.delegate = self
        collectionViewCharacter.registerNib(CharacterCell.self)
        collectionViewCharacter.registerSupplementaryNib(LoadingReusableView.self, kind: UICollectionView.elementKindSectionFooter)
        collectionViewCharacter.collectionViewLayout.invalidateLayout()
        setCollectionViewLayout()
    }
    
    private func setCollectionViewLayout() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionViewCharacter.collectionViewLayout = layout
    }
    
    private func reloadCollectionView(with characters: [CharacterPresentation]) {
        characterList = characters
        collectionViewCharacter.reloadData()
    }
    
    private func showCharacterList(characterList: [CharacterPresentation]) {
        currentOffset += limit
        
        if characterList.count == self.characterList.count || characterList.count % limit != 0 {
            isLoadingMoreVisible = false
        } else {
            isLoadingMoreVisible = true
        }
        
        self.characterList = characterList
        collectionViewCharacter.reloadData()
    }
    
    // MARK: - Selectors
    @objc func loadMoreTapped(sender: UIButton) {
        sender.isHidden = true
        if isLoadingMoreVisible {
            isLoadingMoreVisible = false
            viewModel?.load(with: currentOffset)
        }
    }
}

// MARK: - CharacterListViewModelDelegate
extension CharacterListViewController: CharacterListViewModelDelegate {
    func handleViewModelOutput(_ output: CharacterListViewModelOutput) {
        switch output {
        case .updateTitle(let title):
            self.title = title
        case .setLoading(let isLoading):
            print("isLoading \(isLoading)")
        case .showCharacterList(let characterList):
            showCharacterList(characterList: characterList)
        }
    }
    
    func navigate(to route: CharacterListViewRoute) {
        switch route {
        case .detail(let characterId):
            let viewController = CharacterDetailBuilder.make(with: characterId)
            show(viewController, sender: nil)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension CharacterListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(CharacterCell.self, for: indexPath)
        cell.character = characterList[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterList.count
    }
}

// MARK: - UICollectionViewDelegate
extension CharacterListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.selectCharacter(at: indexPath.row)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CharacterListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width/2) - (space * 3)/2, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: space, left: space, bottom: space, right: space)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return space
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return space
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if self.isLoadingMoreVisible {
            return CGSize(width: collectionView.bounds.size.width, height: loadingMoreViewHeight)
        } else {
            return CGSize.zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let loadingMoreFooterView = collectionView.dequeueReusableView(LoadingReusableView.self, kind: kind, for: indexPath)
            loadingView = loadingMoreFooterView
            loadingView?.backgroundColor = UIColor.clear
            loadingView?.btnLoadMore.addTarget(self, action: #selector(loadMoreTapped(sender:)), for: .touchUpInside)
            return loadingMoreFooterView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView?.activityIndicator.startAnimating()
            
            if self.characterList.count <= 0 {
                self.loadingView?.btnLoadMore.isHidden = true
                self.loadingView?.activityIndicator.isHidden = true
            } else {
                self.loadingView?.btnLoadMore.isHidden = false
                self.loadingView?.activityIndicator.isHidden = false
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView?.activityIndicator.stopAnimating()
        }
    }
}
