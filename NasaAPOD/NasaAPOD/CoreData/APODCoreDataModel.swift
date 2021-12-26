//
//  APODCoreDataModel.swift
//  NasaAPOD
//
//  Created by Mehboob on 17/10/21.
//

import Foundation

import CoreData

@objc(APODCoreDataModel)
public class APODCoreDataModel: NSManagedObject {
    
}

extension APODCoreDataModel {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<APODCoreDataModel> {
        return NSFetchRequest<APODCoreDataModel>(entityName: "APODCoreDataModel")
    }
    
    @NSManaged public var url: String?
    @NSManaged public var hdurl: String?
    @NSManaged public var mediaType: String?
    @NSManaged public var title: String?
    @NSManaged public var isFavourite: Bool
    @NSManaged public var explanation: String?
    @NSManaged public var date: String?
    @NSManaged public var thumbNail: String?
}

extension APODCoreDataModel: Identifiable {
    public func toDataModel() -> APODDataModel {
        return APODDataModel(date: self.date?.getDate(format: .yyyy_MM_dd),
                             explanation: self.explanation,
                             hdurl: self.hdurl,
                             mediaType: MediaType(rawValue: self.mediaType ?? ""),
                             url: self.url,
                             title: self.title,
                             thumbNail: thumbNail,
                             isFavourite: self.isFavourite)
    }
}
