//
//  CollectionViewExtensions.swift
//  MarvelApp
//
//  Created by GOKHAN on 21.04.2022.
//

import UIKit

extension UICollectionView {

    func registerNib<T: UICollectionViewCell>(_: T.Type) {
        self.register(UINib(nibName: String(describing: T.self), bundle: Bundle.main), forCellWithReuseIdentifier: String(describing: T.self))
    }
    
    func registerSupplementaryNib<T: UICollectionReusableView>(_: T.Type, kind: String) {
        self.register(UINib(nibName: String(describing: T.self), bundle: Bundle.main), forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: T.self))
    }
    
    func dequeue<T: UICollectionViewCell>(_: T.Type, for indexPath: IndexPath) -> T {
        guard
            let cell = dequeueReusableCell(withReuseIdentifier: String(describing: T.self),
                                           for: indexPath) as? T
            else { fatalError("Could not deque cell with type \(T.self)") }
        
        return cell
    }
    
    func dequeueReusableView<T: UICollectionReusableView>(_: T.Type, kind: String, for indexPath: IndexPath) -> T {
        guard
            let view = dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: String(describing: T.self),
                for: indexPath) as? T
            else { fatalError("Could not deque view with type \(T.self)") }
        
        return view
    }
}
