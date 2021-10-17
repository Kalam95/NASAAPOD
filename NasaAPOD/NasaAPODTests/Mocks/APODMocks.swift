// Created by mehboob Alam

import NasaAPOD
import XCTest


class APODAPIMock: APODAPIType {

    internal var networkClient: NetworkClientType
    var json: [String:Any]?
    init(client: NetworkClientType) {
        self.networkClient = client
    }

    func sendAPODRequest(date: String) -> PublishSubject<APODDataModel> {
        if let json = json {
            let data = try? JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted])
            (networkClient as? NetworkClientMock)?.data = data
        }
        return networkClient.getRequest(path: "", parameters: [:])
    }

    
}

class NetworkClientMock: NetworkClientType {
    init() {
        
    }
    fileprivate var data: Data?
    func getRequest<ResponseType>(path: String, parameters: [String : String]) -> PublishSubject<ResponseType> where ResponseType : Decodable {
        getMoackData()
    }
    
    func postRequest<ResponseType>(path: String, body: Encodable?) -> PublishSubject<ResponseType> where ResponseType : Decodable {
        getMoackData()
    }
    
    func putRequest<ResponseType>(path: String, body: Encodable?) -> PublishSubject<ResponseType> where ResponseType : Decodable {
        getMoackData()
    }
    
    func deleteRequest<ResponseType>(path: String, parameters: [String : String]) -> PublishSubject<ResponseType> where ResponseType : Decodable {
        getMoackData()
    }

    private func getMoackData<ResponseType>() -> PublishSubject<ResponseType> where ResponseType : Decodable {
        let responseSubject = PublishSubject<ResponseType>()
        DispatchQueue.global(qos: .default).asyncAfter(deadline: .now() + .microseconds(200), execute: {[unowned responseSubject] in
            self.processData(responseSubject: responseSubject)
        })
        return responseSubject
    }

    private func processData<ResponseType>(responseSubject: PublishSubject<ResponseType>) where ResponseType : Decodable {
        guard let data = data else {
            responseSubject.onError(.noData)
            return
        }
        do {
            // parsing data
            let decoder = JSONDecoder()
            let formater = DateFormatter()
            formater.dateFormat = DateFormat.yyyy_MM_dd.rawValue
            decoder.dateDecodingStrategy = .formatted(formater)
            let apiResponse = try decoder.decode(ResponseType.self, from: data)
            responseSubject.onNext(apiResponse)
        } catch let error {
            print(error.localizedDescription)
            responseSubject.onError(HTTPNetworkError.unableToDecode)
        }
    }
}
