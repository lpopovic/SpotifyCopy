//
//  HapticsManager.swift
//  Spotify
//
//  Created by Lazar Popovic on 2/28/21.
//

import UIKit
import Foundation

final class HapticsManager {
    static let shared = HapticsManager()
    
    private init () {}
    
    public func vibrateForSelection() {
        DispatchQueue.main.async {
            let generator = UISelectionFeedbackGenerator()
            generator.prepare()
            generator.selectionChanged()
        }
    }
    
    public func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType) {
        DispatchQueue.main.async {
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            generator.notificationOccurred(type)
        }
    }
}
