//
//  ResearchStudy.swift
//  TrialSearch
//
//  Created by Admin on 1/25/24.
//

import Foundation
import UIKit

struct APIResponse: Codable {
    let studyFieldsResponse: StudyFieldsResponse
    
    enum CodingKeys: String, CodingKey {
        case studyFieldsResponse = "StudyFieldsResponse"
    }
}

struct StudyFieldsResponse: Codable {
    
    let studyFields: [ResearchStudy]
    
    enum CodingKeys: String, CodingKey {
        case studyFields = "StudyFields"
    }
}

struct ResearchStudy: Codable {
    let briefTitle: [String]
    let startDate: [String]
    let status: [String]

    
    enum CodingKeys: String, CodingKey {
        case briefTitle = "BriefTitle"
        case status = "OverallStatus"
        case startDate = "StartDate"

        
    }
    
    static func getResearchStudies(handleCompletion: @escaping ([ResearchStudy]) -> ()) {
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: "https://classic.clinicaltrials.gov/api/query/study_fields?expr=heart+attack&fields=BriefTitle%2COverallStatus%2CStartDate%2CCondition%2CHealthyVolunteers%2CBriefSummary%2CGender%2CCompletionDate%2CLocationCity%2CLocationContactEMail%2CLocationContactName%2CMinimumAge%2CLocationContactPhone%2CLocationContactRole%2CLocationCountry%2CLocationFacility%2CLocationState%2CLocationStatus%2CLocationZip%2CMaximumAge&min_rnk=1&max_rnk=&fmt=json")!),
                                   completionHandler: { data, urlResponse, error in
            if let error  = error {
                print(error.localizedDescription)
                return
            }
            let apiResponse = try! JSONDecoder().decode(APIResponse.self, from: data!)
            handleCompletion(apiResponse.studyFieldsResponse.studyFields)
        }).resume()
    }
    
}
