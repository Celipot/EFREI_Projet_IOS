//
//  Network.swift
//  Test
//
//  Created by user186364 on 07/04/2021.
//

import Foundation
import ModelIO

class Network {
    let ApiAddress = "https://api.airtable.com/v0/appXKn0DvuHuLw4DV"
    let ApiKey = "keyZoaahVuD0KvuoM"
    
    enum APIPath : String{
        case schedule = "/Schedule/"
        case sponsors = "/Sponsors/"
        case speakers = "/Speakers%20%26%20attendees/"
        case location = "/Event%20locations/"
        case topic = "/Topics%20%26%20themes/"
    }
    
    func createRequest(ressourcePath : String) -> URLRequest {
        let url = URL(string: ApiAddress + ressourcePath)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 100
        // Authentification
        let accessToken = ApiKey
        request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        
        return request
    }
    
    func getFromAPI<T : Codable>(ressourcePath : String, callback: @escaping ((errorType: Error?,errorMessage: String?), T?) -> Void) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: createRequest(ressourcePath: ressourcePath)) {
            (data, response, error)
            in
            if let data = data, error == nil {
                if let responseHttp = response as? HTTPURLResponse {
                    if responseHttp.statusCode == 200 {
                        if let response = try?
                            JSONDecoder().decode(T.self, from: data) {
                            callback((nil, nil), response)
                        }
                        else {
                            callback((CustomError.parsingError, "parsing error"), nil)
                        }
                    }
                    else {
                        callback((CustomError.statusCodeError, "status code: \(responseHttp.statusCode)"), nil)
                    }
                }
            }
            else {
                callback((CustomError.requestError, error.debugDescription), nil)
            }
        }
        task.resume()
    }
    
    func getScheduleList(callback: @escaping ((errorType: Error?,errorMessage: String?), Records<Schedule>?) -> Void) {
        let sortByStartAsc = "?sort%5B0%5D%5Bfield%5D=Start&sort%5B0%5D%5Bdirection%5D=asc"
        getFromAPI(ressourcePath: APIPath.schedule.rawValue + sortByStartAsc,callback: callback)
    }
}
