//
//  ContentView.swift
//  ComponentsKit
//
//  Created by Ульяна Гритчина on 22.02.2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = ViewModel()
    var body: some View {
        NavigationView {
            List {
                Button("Web Browser") {
                    viewModel.showWebBrowserView()
                }
                .font(.headline)
                
                NavigationLink("Range Slider") {
                    RangeSliderView()
                }
                .font(.headline)
                .foregroundStyle(.blue)
                
                Button("Activity View") {
                    viewModel.showsActivityView()
                }
                .font(.headline)
            }
            .navigationTitle("Components Kit")
            
            // MARK: Web Browser
            
            .fullScreenCover(isPresented: $viewModel.isShowWebBrowserView) {
                WebBrowserView(url: viewModel.stringURL)
            }
            
            // MARK: Activity View
            
            .sheet(isPresented: $viewModel.isShowActivityView) {
                ActivityView(activityItems: .constant(viewModel.activityItems))
            }
        }
    }
}

#Preview {
    HomeView()
}
