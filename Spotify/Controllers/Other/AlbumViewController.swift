//
//  AlbumViewController.swift
//  Spotify
//
//  Created by MacBook on 3/1/21.
//

import UIKit

class AlbumViewController: UIViewController {
    
    private var album: Album
    
    init(album: Album) {
        self.album = album
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = album.name
        view.backgroundColor = .systemBackground
        
        APICaller.shared.getAlbumDetails(for: album) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    break
                case .failure(let error):
                    break
                }
            }
        }
    }
    
}
