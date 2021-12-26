//
//  APODViewModel.swift
//  NasaAPOD
//
//  Created by Mehboob on 16/10/21.
//

import Foundation
import UIKit
import CoreData

public class APODDetailViewModel {
    private var data: APODDataModel

    public init(data: APODDataModel) {
        self.data = data
    }

    public var url: String {
        data.url ?? ""
    }

    public var title: String {
        data.title ?? ""
    }

    public var explanation: String {
        return data.explanation ?? ""
    }

    public var type: MediaType? {
        return data.mediaType
    }

    public var date: String {
        data.date?.getString(format: .dd_MMM_yyyy) ?? "Details"
    }

    public var isFavourite: Bool {
        data.isFavourite
    }

    public var buttonTitle: String {
        isFavourite ? "Remove from favourites" : "Add to Favourites"
    }

    public var thumNailURL: String {
        data.thumbNail ?? ""
    }

    public var imageURL: String {
        data.imageURL ?? ""
    }

    public func updateDatabase() {
        data.isFavourite = !isFavourite
        CoreDataManager.shared.save(data: data)
    }
}
