// Created by mehboob Alam

import Foundation

public class SearchAPODViewModel {
    private let apiCleint: APODAPIType
    private var data: APODDataModel?
    public private(set) var signal: PublishSubject<Void>!
    private var holder: PublishSubject<APODDataModel>?
    private var holders: PublishSubject<[APODDataModel]>?

    public init(apiCleint: APODAPIType) {
        self.apiCleint = apiCleint
        self.signal = PublishSubject<Void>()
    }

    deinit {
        signal.subscribe(onNext: nil, onError: nil, onComplete: nil)
        signal = nil
    }

    public func sendRequest(date: Date) {
        let coreManager = CoreDataManager.shared
        holder = apiCleint.sendAPODRequest(date: date.getString(format: .yyyy_MM_dd))
        holder?.subscribe { [weak self, weak coreManager] data in
            self?.data = data
            DispatchQueue.main.async {[weak self] in
                self?.signal.onNext(())
            }
            coreManager?.saveIfReqired(data: data)
        } onError: { [weak self] error in
            DispatchQueue.main.async {[weak self] in
                self?.signal.onError(error)
            }
        }
    }

    //MARK:- Representable Data
    public func getData() -> APODDataModel? {
        // NOTE** Since, APODDataModel is a Struct(value type), it passing directly will not break MVVM.
        return data
    }
}
