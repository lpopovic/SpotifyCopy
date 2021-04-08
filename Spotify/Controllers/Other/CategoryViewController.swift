//
//  CategoryViewController.swift
//  Spotify
//
//  Created by Lazar Popovic on 3/24/21.
//

import UIKit

class CategoryViewController: UIViewController {
    
    let category: Category
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { ( _, _) -> NSCollectionLayoutSection? in
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        ))
        item.contentInsets = NSDirectionalEdgeInsets(top: 5,
                                                     leading: 5,
                                                     bottom: 5,
                                                     trailing: 5)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                                          heightDimension: .absolute(250)),
                                                       subitem: item,
                                                       count: 2)
        group.contentInsets = NSDirectionalEdgeInsets(top: 5,
                                                      leading: 5,
                                                      bottom: 5,
                                                      trailing: 5)
        
        return NSCollectionLayoutSection(group: group)
        
    }))
    
    // MARK: - Init
    
    init(category: Category) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private var playlists = [Playlist]()
   
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = category.name
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FeaturePlaylistCollectionViewCell.self,
                                forCellWithReuseIdentifier: FeaturePlaylistCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        APICaller.shared.getGategoryPlaylists(category: category) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let models):
                    self?.playlists = models
                    self?.collectionView.reloadData()
                    break
                case .failure(let error):
                    UIAlertController.showApiCallerMessage(self, title: nil, message: error.localizedDescription)
                    break
                }
            }
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
}

extension CategoryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playlists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FeaturePlaylistCollectionViewCell.identifier,
                for: indexPath) as? FeaturePlaylistCollectionViewCell else {
            return UICollectionViewCell()
        }
        let playlist = playlists[indexPath.row]
        let viewModel = FeaturedPlaylistCellViewModel(name: playlist.name,
                                                      artworkURL: URL(string: playlist.images.first?.url ?? ""),
                                                      creatorName: playlist.owner.display_name)
        cell.configure(with: viewModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let vc = PlaylistViewController(playlist: playlists[indexPath.row])
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
