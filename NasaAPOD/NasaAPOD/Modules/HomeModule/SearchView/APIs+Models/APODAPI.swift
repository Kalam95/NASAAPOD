// Created by mehboob Alam

import Foundation


/// Protocol to make API for Pockomen reated, it is made to achive testability
public protocol APODAPIType: APIClient {
    func sendAPODRequest(date: String) -> PublishSubject<APODDataModel>
}

/// Class for Pockomen reated API and confirms the protocol mentioned above
class APODAPI: APODAPIType {

    let networkClient: NetworkClientType

    init(networkClient: NetworkClientType) {
        self.networkClient = networkClient
    }

    func sendAPODRequest(date: String) -> PublishSubject<APODDataModel> {
        networkClient.getRequest(path: APIEndPoints.apod.rawValue ,
                                 parameters: [APIKey.api_key.rawValue : API_KEY,
                                              APIKey.date.rawValue :  date])
    }
}
