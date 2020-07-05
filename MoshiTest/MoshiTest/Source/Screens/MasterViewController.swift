//
//  MasterViewController.swift
//  MoshiTest
//
//  Created by Hayden Jamieson on 05/07/2020.
//  Copyright © 2020 Hayden Jamieson. All rights reserved.
//

import UIKit
import Kingfisher

class MasterViewController: UIViewController {
    
    @IBOutlet weak var albumCollectionView: UICollectionView!
    
    private let viewModel = MasterViewModel()
    
    private let cellId = "AlbumCell"
    
    private var albums: [Item] = [] {
        didSet {
            albumCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        
        setNavigationBarProperties()
        
        viewModel.getLatestAlbumReleases { [weak self] (albums) in
            
            DispatchQueue.main.async {
                self?.albums = albums ?? []
            }
        }
    }
    
    private func configureCollectionView() {
        
        albumCollectionView.dataSource = self
        
        albumCollectionView.delegate = self
        
        albumCollectionView.register(UINib(nibName: cellId, bundle: nil), forCellWithReuseIdentifier: cellId)
        
        albumCollectionView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    private func setNavigationBarProperties() {
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        title = "New Album Releases"
    }
}

extension MasterViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell: AlbumCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? AlbumCell else { return UICollectionViewCell() }
        
        cell.configure(with: albums[indexPath.row])
        
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenWidth = UIScreen.main.bounds.width
        
        let padding: CGFloat = 32.0
        
        let cellWidth = (screenWidth / 2) - padding

        return CGSize(width: cellWidth, height: cellWidth * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = albums[indexPath.row]
        
        let detailScreen = DetailViewController()
        
        detailScreen.album = item
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        navigationController?.pushViewController(detailScreen, animated: true)
    }
}

extension MasterViewController: ShareDelegate {
    
    func didTapShare(with url: URL) {
        
        let items = [url]
        
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        navigationController?.present(ac, animated: true)
    }
}
