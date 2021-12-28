//
//  AstronomyListViewModel.swift
//
//  Created by mehboob Alam 
//

import Foundation

public class AstronomyListViewModel {
    /// saved data list from Coredata Module
    private var dataList: [APODDataModel]? {
        willSet {
            filteredList = newValue
        }
    }
    
    /// Filtered list on the basis of date
    private var filteredList: [APODDataModel]?
    public private(set) var signal: PublishSubject<Void>!
    let viewType: ListType

    init(viewType: ListType) {
        self.viewType = viewType
        self.signal = PublishSubject()
    }

    deinit {
        signal.subscribe(onNext: nil, onError: nil, onComplete: nil)
    }

    func getData() {
        CoreDataManager.shared.getSearchListData(for: viewType) { [weak self] dataList in
            self?.dataList = dataList
            self?.signal.onNext(())
        }
    }

    func filter(forDate date: Date?) {
        if date == nil {
            filteredList = dataList
            return
        }
        filteredList = dataList?.filter({ $0.date?.getString(format: .yyyy_MM_dd) == date?.getString(format: .yyyy_MM_dd)}) ?? []
    }

    public var numberOfRows: Int {
        return filteredList?.count ?? 0
    }

    public func delete(at index: Int) {
        let data = filteredList?[index]
        filteredList?.remove(at: index)
        guard let deleteIndex = dataList?.firstIndex(where: { $0.date == data?.date }),
                let date = data?.date?.getString(format: .yyyy_MM_dd) else { return }
        dataList?.remove(at: deleteIndex)
        CoreDataManager.shared.delete(forDate: date)
    }

    public func getItem(at index: Int) -> APODDataModel? {
        filteredList?[index]
    }
}
