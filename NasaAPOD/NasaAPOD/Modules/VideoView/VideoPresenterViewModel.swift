//
//  VideoPresenterViewModel.swift
//  NasaAPOD
//
//  Created by Mehboob Alam on 26.12.21.
//

import Foundation

public struct VideoViewModel {
    private var urlString: String

    public var lastPathComponent: String {
        return url?.lastPathComponent ?? ""
    }
    
    public init(url: String)  {
        self.urlString = url
    }

    public var isYoutube: Bool {
        urlString.contains("youtube")
    }

    public var url: URL? {
        URL(string: urlString)
    }
}
