//
//  AvatarCollectionView.swift
//  RoohiOS
//
//  Created by Cezar_ on 09.02.24.
//

import UIKit

class AvatarCollectionView: UICollectionView {
    
    weak var mainView: CreateProfileViewController?
    
    var avatars = [ProfileAvatar]() {
        didSet {
            self.reloadData()
        }
    }
    var currentIndex: Int = 0 {
        didSet {
            scrollToItem()
            mainView?.updateNameLabel(with: avatars[currentIndex].name)
        }
    }
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        super.init(frame: .zero, collectionViewLayout: layout)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionView() {
        delegate = self
        dataSource = self
        register(AvatarCollectionViewCell.self, forCellWithReuseIdentifier: AvatarCollectionViewCell.typeName)
        setupGestureRecognizers()
        backgroundColor = .gray
        contentInset = UIEdgeInsets(top: 0, left: 100, bottom: 0, right: 100)
    }
    
    func setupAvatars(with avatars: [ProfileAvatar]) {
        self.avatars = avatars
    }
    
    func scrollToItem() {
        scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
    }
}

//MARK: - Adding Gectures
extension AvatarCollectionView {
    private func setupGestureRecognizers() {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            addGestureRecognizer(tapGesture)
        }

    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: self)
        let indexPath = indexPathForItem(at: location)

        guard let tappedIndexPath = indexPath else { return }

        if tappedIndexPath.row > currentIndex {
            currentIndex = min(currentIndex + 1, avatars.count - 1)
        } else if tappedIndexPath.row < currentIndex {
            currentIndex = max(currentIndex - 1, 0)
        }

        scrollToItem()
    }
}

//MARK: - ScrollView Delegate
extension AvatarCollectionView: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            updateCurrentIndex()
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updateCurrentIndex()
    }

    private func updateCurrentIndex() {
        let visibleRect = CGRect(origin: contentOffset, size: bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        guard let indexPath = indexPathForItem(at: visiblePoint) else { return }

        currentIndex = indexPath.row
    }
}

//MARK: - CollectionView Delegate
extension AvatarCollectionView: UICollectionViewDelegate {

}

//MARK: - CollectionView DataSource
extension AvatarCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return avatars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: AvatarCollectionViewCell.typeName, for: indexPath) as? AvatarCollectionViewCell else { return UICollectionViewCell()}
        cell.setupImage(image: avatars[indexPath.row].base64.base64Convert())
        return cell
    }
}

//MARK: - CollectionView Delegate FlowLayout
extension AvatarCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
}
