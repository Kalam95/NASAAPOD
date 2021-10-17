//
//  CoreDataManager.swift
//  NasaAPOD
//
//  Created by Mehboob on 17/10/21.
//

import CoreData

final class CoreDataManager {

    static let shared = CoreDataManager()
    private init() {
        
    }
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NasaAPOD")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    /// Methdo to save or overide data
    /// - Parameter data: APOD details
    func save(data: APODDataModel) {
        let context = persistentContainer.viewContext
        let managedObject = APODCoreDataModel(context: context)
        data.covertTo(data: managedObject)
        saveContext()
    }

    
    /// Method to fetch data from core data
    /// - Parameters:
    ///   - type: for what type, favouries or history
    ///   - complition: complituion to update the result
    func getSearchListData(for type: ListType, complition: @escaping ([APODDataModel]) -> Void) {
        persistentContainer.viewContext.perform {
            do {
                let request = APODCoreDataModel.fetchRequest()
                if type == .favourites {
                    request.predicate = NSPredicate(format: "isFavourite == %@", NSNumber(value: true))
                }
                let result = try request.execute()
                complition(result.map({$0.toDataModel()}))
            } catch let error {
                print(error.localizedDescription)
                complition([])
            }
        }
    }

    
    /// Methdo to save data if it does not exist else update the fileds
    /// - Parameter data: APOD details
    func saveIfReqired(data: APODDataModel) {
        /// check if user has alreadly searched on this date, if yes then update the data except from
        /// is favourite key as that will not be comming from server
        persistentContainer.viewContext.perform {[weak self] in
            do {
                let request = APODCoreDataModel.fetchRequest()
                request.predicate = NSPredicate(format: "date == %@",
                                                data.date?.getString(format: .yyyy_MM_dd) ?? "")
                if let result = try request.execute().first {
                    let isFavourite = result.isFavourite
                    data.covertTo(data: result)
                    result.isFavourite = isFavourite
                    self?.saveContext()
                } else {
                    self?.save(data: data)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }

    /// Methdo to delete data if it exists
    /// - Parameter date: date for wich data has to be deleted
    func delete(forDate date: String) {
        persistentContainer.viewContext.perform {[weak self] in
            let fetchRequest = APODCoreDataModel.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "date == %@", date)
            if let result = try? fetchRequest.execute() {
                for object in result {
                    self?.persistentContainer.viewContext.delete(object)
                    self?.saveContext()
                }
            }
        }
        
    }
}
