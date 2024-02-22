//
//  WebViewRepresentable.swift
//  ComponentsKit
//
//  Created by Ульяна Гритчина on 22.02.2024.
//

import SwiftUI
import WebKit

/// A container for using a WKWebView in SwiftUI
public struct WebViewRepresentable: View, UIViewRepresentable {
    public let webView: WKWebView
    
    public init(webView: WKWebView) {
        self.webView = webView
    }
    
    public func makeUIView(context: UIViewRepresentableContext<WebViewRepresentable>) -> WKWebView {
        webView
    }
    
    public func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebViewRepresentable>) {
    }
}
