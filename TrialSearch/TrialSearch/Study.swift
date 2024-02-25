//
//  Study.swift
//  TrialSearch
//
//  Created by Admin on 2/1/24.
//

import Foundation

import UIKit

struct Response: Decodable {
    let studyFieldsResponse: StudyFieldsResponse
    
    enum CodingKeys: String, CodingKey {
        case studyFieldsResponse = "StudyFieldsResponse"
    }
}

struct StudyFieldsResponse: Decodable {
    
    let studyFields: [Study]
    
    enum CodingKeys: String, CodingKey {
        case studyFields = "StudyFields"
    }
}


struct Study: Decodable {
    let briefTitle : [String]
    let status: [String]
    let startDate: [String]
    let healthy: [String]
    let condition : [String]
    let summary : [String]
    let gender  : [String]
    let city : [String]
    let email : [String]
    let contactName : [String]
    let minAge : [String]
    let phone : [String]
    let country :  [String]
    let location : [String]
    let state : [String]
    let zipCode : [String]
    let maxAge : [String]

    
    
    enum CodingKeys: String, CodingKey {
        case briefTitle = "BriefTitle"
        case status = "OverallStatus"
        case startDate = "StartDate"
        case healthy = "HealthyVolunteers"
        case condition = "Condition"
        case summary = "BriefSummary"
        case gender = "Gender"
        case city = "LocationCity"
        case email = "LocationContactEMail"
        case contactName = "LocationContactName"
        case minAge = "MinimumAge"
        case phone = "LocationContactPhone"
        case country = "LocationCountry"
        case location = "LocationFacility"
        case state = "LocationState"
        case zipCode = "LocationZip"
        case maxAge = "MaximumAge"
    }
}
