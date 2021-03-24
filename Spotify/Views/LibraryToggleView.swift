//
//  LibraryToggleView.swift
//  Spotify
//
//  Created by MacBook on 3/24/21.
//

import UIKit

protocol LibraryToggleViewDelegate: AnyObject {
    func libraryToggleViewDidTapPlaylists(_ toggleView: LibraryToggleView)
    func libraryToggleViewDidTapAlbums(_ toggleView: LibraryToggleView)
}

class LibraryToggleView: UIView {
    
    enum State {
        case playlist
        case album
    }
    
    var state: State = .playlist
    
    weak var delegate: LibraryToggleViewDelegate?
    
    private let playlistsButton: UIButton = {
        let button = UIButton()
        button.setTitleColor( .label, for: .normal)
        button.setTitle("Playlist", for: .normal)
        return button
    }()
    
    private let albumsButton: UIButton = {
        let button = UIButton()
        button.setTitleColor( .label, for: .normal)
        button.setTitle("Albums", for: .normal)
        return button
    }()
    
    private let indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 4
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(albumsButton)
        addSubview(playlistsButton)
        addSubview(indicatorView)
        
        albumsButton.addTarget(self, action: #selector(didTapAlbums), for: .touchUpInside)
        playlistsButton.addTarget(self, action: #selector(didTapPlaylists), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playlistsButton.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        albumsButton.frame = CGRect(x: playlistsButton.right, y: 0, width: 100, height: 40)
        layoutIndicator()
    }
    
    @objc private func didTapPlaylists() {
        self.state = .playlist
        UIView.animate(withDuration: 0.2) {
            self.layoutIndicator()
        }
        delegate?.libraryToggleViewDidTapPlaylists(self)
    }
    
    @objc private func didTapAlbums() {
        self.state = .album
       
        delegate?.libraryToggleViewDidTapAlbums(self)
    }
    
    func layoutIndicator() {
        switch self.state {
        case .playlist:
            indicatorView.frame = CGRect(x: 0, y: playlistsButton.bottom, width: 100, height: 3)
        case .album:
            indicatorView.frame = CGRect(x: 100, y: playlistsButton.bottom, width: 100, height: 3)
        }
    }
    
    func update(for state: State) {
        self.state = state
        UIView.animate(withDuration: 0.2) {
            self.layoutIndicator()
        }
    }
}
