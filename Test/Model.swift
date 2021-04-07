//
//  Model.swift
//  Test
//
//  Created by user186364 on 07/04/2021.
//

import Foundation

struct Records<T : Codable> : Codable{
    var records : [RecordItem<T>]
}

struct RecordItem<T: Codable> : Codable, Identifiable {
    var item: T
    var id: String
}

struct Schedule: Codable {
    var activity: String
    var start: String?
    var end: String?
    var type: [String]?
    var speaker: [String]?
    var topic: [String]?
    var location: [String]?
    var notes: String?
    
    
    enum CodingKeys : String, CodingKey {
        case activity = "Activity"
        case start = "Start"
        case end = "End"
        case type = "Type"
        case speaker = "Speaker(s)"
        case topic = "Topic / theme"
        case location = "Location"
        case notes = "Notes"
    }
}

enum CustomError: Error {
    case requestError
    case statusCodeError
    case parsingError
}
