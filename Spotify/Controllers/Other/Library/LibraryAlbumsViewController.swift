//
//  LibraryAlbumsViewController.swift
//  Spotify
//
//  Created by Lazar Popovic on 3/24/21.
//

import UIKit

class LibraryAlbumsViewController: UIViewController {

    var albums = [Album]()
    
    private let noAlbumView = ActionLabelView()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(SearchResultSubtitleTableViewCell.self,
                           forCellReuseIdentifier: SearchResultSubtitleTableViewCell.identifier)
        tableView.isHidden = true
        
        return tableView
    }()
    
    private var observer: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        setUpNoAlbumView()
        fetchData()
        observer = NotificationCenter.default.addObserver(
            forName: .albumSavedNotification,
            object: nil,
            queue: .main,
            using: { [weak self] _ in
                self?.fetchData()
            }
        )
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        noAlbumView.frame = CGRect(x: (view.width - 150) / 2, y: (view.height - 150) / 2, width: 150, height: 150)
        
        tableView.frame = view.bounds
    }
    
    private func setUpNoAlbumView() {
        view.addSubview(noAlbumView)
        noAlbumView.delegate = self
        noAlbumView.configure(
            with: ActionLabelViewViewModal(
                text: "You have not saved any albums yet.",
                actionTitle: "Browse"
            )
        )
    }
    
    private func fetchData() {
        self.albums.removeAll()
        self.updateUI()
        APICaller.shared.getCurrentUserAlbums { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self?.albums = model
                    self?.updateUI()
                    break
                case .failure(let error):
                    UIAlertController.showApiCallerMessage(self, title: nil, message: error.localizedDescription)
                    break
                }
            }
        }
    }
    
    private func updateUI() {
        if albums.isEmpty {
            // Show label
            noAlbumView.isHidden = false
            tableView.isHidden = true
            tableView.reloadData()
        } else {
            // Show table
            noAlbumView.isHidden = true
            tableView.isHidden = false
            tableView.reloadData()
        }
    }
    
}

extension LibraryAlbumsViewController: ActionLabelViewDelegate {
    func actionLabelViewDidTapButton(_ actionView: ActionLabelView) {
        // Show creation UI
        tabBarController?.selectedIndex = 0
    }
    
}

extension LibraryAlbumsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SearchResultSubtitleTableViewCell.identifier,
                for: indexPath) as? SearchResultSubtitleTableViewCell else {
            return UITableViewCell()
        }
        
        let album = albums[indexPath.row]
        let viewModal = SearchResultSubtitleTableViewCellViewModel(
            title: album.name,
            subtitle: album.artists.first?.name ?? "-",
            imageURL: URL(string: album.images.first?.url ?? "")
        )
        
        cell.configure(with: viewModal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        HapticsManager.shared.vibrateForSelection()
        let album = albums[indexPath.row]
        
        let vc = AlbumViewController(album: album)
        vc.navigationItem.largeTitleDisplayMode = .never
    
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

