// Created by mehboob Alam

import Foundation

/// Data Model for network JSON response for Tile
public struct APODDataModel: Codable {
    public var date: Date?
    public var explanation: String?
    public var hdurl: String?
    public var mediaType: MediaType?
    public var url: String?
    public var title: String?
    public var isFavourite: Bool = false

    public enum CodingKeys: String, CodingKey {
        case mediaType = "media_type", date, title, url, hdurl, explanation
    }

    func covertTo(data: APODCoreDataModel) {
        data.date = self.date?.getString(format: .yyyy_MM_dd)
        data.explanation = self.explanation
        data.hdurl = self.hdurl
        data.mediaType = self.mediaType?.rawValue
        data.url = self.url
        data.title = self.title
        data.isFavourite = self.isFavourite
    }

    public init(date: Date?,
                explanation: String?,
                hdurl: String?,
                mediaType: MediaType?,
                url: String?,
                title: String?,
                isFavourite: Bool = false) {
        self.date = date
        self.explanation = explanation
        self.hdurl = hdurl
        self.mediaType = mediaType
        self.url = url
        self.title = title
        self.isFavourite = isFavourite
    }
}

/// Enum for possibl Tile Types
public enum MediaType: String, Codable {
    case image, video
}
