// Created by mehboob Alam

import Foundation


/// Protocol to make API for Pockomen reated, it is made to achive testability
public protocol APODAPIType: APIClient {
    func sendAPODRequest(date: String) -> PublishSubject<APODDataModel>
    func sendApodLast50Days() -> PublishSubject<[APODDataModel]>
}

/// Class for Pockomen reated API and confirms the protocol mentioned above
class APODAPI: APODAPIType {

    let networkClient: NetworkClientType

    init(networkClient: NetworkClientType) {
        self.networkClient = networkClient
    }

    func sendAPODRequest(date: String) -> PublishSubject<APODDataModel> {
        networkClient.getRequest(path: APIEndPoints.apod.rawValue ,
                                 parameters: [APIKey.api_key.rawValue: API_KEY,
                                              APIKey.thumbs.rawValue: true.description,
                                              APIKey.date.rawValue:  date])
    }

    func sendApodLast50Days() -> PublishSubject<[APODDataModel]> {
        let endDate = Date().getString(format: .yyyy_MM_dd)
        let startDate = Date().addingTimeInterval(-50*24*60*60).getString(format: .yyyy_MM_dd)
        return networkClient.getRequest(path: APIEndPoints.apod.rawValue ,
                                 parameters: [APIKey.api_key.rawValue: API_KEY,
                                              APIKey.thumbs.rawValue: true.description,
                                              APIKey.startDate.rawValue: startDate,
                                              APIKey.endDate.rawValue: endDate])
    }
}
