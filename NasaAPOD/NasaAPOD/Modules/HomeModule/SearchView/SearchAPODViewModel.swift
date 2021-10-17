// Created by mehboob Alam

import Foundation
import CoreMIDI

public class SearchAPODViewModel {
    private let apiCleint: APODAPIType
    private var data: APODDataModel?
    public let signal: PublishSubject<Void>
    private var holder: PublishSubject<APODDataModel>?

    public init(apiCleint: APODAPIType) {
        self.apiCleint = apiCleint
        self.signal = PublishSubject<Void>()
    }

    deinit {
        holder = nil// in case of RxSwift and combine it is not requred as they handles it in them only
    }

    public func sendRequest(date: Date) {
        holder = apiCleint.sendAPODRequest(date: date.getString(format: .yyyy_MM_dd))
        holder?.subscribe { [weak self] data in
            self?.data = data
            DispatchQueue.main.async {[weak self] in
                self?.signal.onNext(())
            }
            CoreDataManager.shared.saveIfReqired(data: data)
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
