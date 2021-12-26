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
    public var thumbNail: String?

    public enum CodingKeys: String, CodingKey {
        case mediaType = "media_type", thumbNail = "thumbnail_url" , date, title, url, hdurl, explanation
    }

    public var imageURL: String? {
        mediaType == .video ? thumbNail : url
    }

    public func covertTo(data: APODCoreDataModel) {
        data.date = date?.getString(format: .yyyy_MM_dd)
        data.explanation = explanation
        data.hdurl = hdurl
        data.mediaType = mediaType?.rawValue
        data.url = url
        data.title = title
        data.isFavourite = isFavourite
        data.thumbNail = thumbNail
    }

    public init(date: Date?,
                explanation: String?,
                hdurl: String?,
                mediaType: MediaType?,
                url: String?,
                title: String?,
                thumbNail: String?,
                isFavourite: Bool = false) {
        self.date = date
        self.explanation = explanation
        self.hdurl = hdurl
        self.mediaType = mediaType
        self.url = url
        self.title = title
        self.isFavourite = isFavourite
        self.thumbNail = thumbNail
    }
}

/// Enum for possibl Tile Types
public enum MediaType: String, Codable {
    case image, video
}
