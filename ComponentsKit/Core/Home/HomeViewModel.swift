//
//  HomeViewModel.swift
//  ComponentsKit
//
//  Created by Ульяна Гритчина on 22.02.2024.
//

import Foundation

extension HomeView {
    @MainActor final class ViewModel: ObservableObject {
        
        @Published var isShowWebBrowserView = false
        @Published var isShowActivityView = false
        
        let stringURL = "https://www.apple.com"
        let activityItems = ["https://www.apple.com"]
        
        enum Components {
            case webBrowser
            case activityController
            case rangeSlider
        }
        
        func showWebBrowserView() {
            isShowWebBrowserView = true
        }
        
        func showsActivityView() {
            isShowActivityView = true
        }
    }
}
