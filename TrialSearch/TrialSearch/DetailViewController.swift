//
//  DetailViewController.swift
//  TrialSearch
//
//  Created by Admin on 1/29/24.
//

import Foundation
import UIKit




class DetailViewController: UIViewController {
    var study: Study?
    
    
    @IBOutlet weak var backButton: UINavigationItem!
    @IBOutlet weak var titleTextView: UITextView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    
    func configureView() {
        guard let study = study else {
            print("Study object is nil.")
            print(study?.briefTitle.first ?? "")
            return
        }
       
        let title = study.briefTitle.first ?? "Unkown Status"
        let status = study.status.first ?? "Unknown Status"
        let startDate = study.startDate.first ?? "Unknown Status"
        let healthy = study.healthy.first ?? "Unknown Status"
        let condition = study.condition.first ?? "Unknown Status"
        let summary = study.summary.first ?? "Unknown Status"
        _ = study.gender.first ?? "Unknown Status"
        _ = study.city.first ?? "Unknown Status"
        _ = study.email.first ?? "Unknown Status"
        let contactName = study.contactName.first ?? "Unknown Status"
        let minAge = study.minAge.first ?? "Unknown Status"
        let phone = study.phone.first ?? "Unknown Status"
        let country = study.country.first ?? "Unknow Status"
        let location = study.location.first ?? "Unknown Status"
        let state = study.state.first ?? "Unknown Status"
        let zip = study.zipCode.first ?? "Unknown Status"
        let maxAge = study.maxAge.first ?? "Unknown Status"
       
        
        // Create an attributed string with line breaks between each part
        let attributedString = NSMutableAttributedString()
        attributedString.append(NSAttributedString(string: "Title: " + title + "\n"))
        attributedString.append(NSAttributedString(string: "Status: " + status + "\n"))
        attributedString.append(NSAttributedString(string: "Start Date: " + startDate + "\n"))
        attributedString.append(NSAttributedString(string: "Health Status: " + healthy + "\n"))
        attributedString.append(NSAttributedString(string: "Condition: " + condition + "\n\n"))
        
        attributedString.append(NSAttributedString(string: "Summary: \n" + summary + "\n\n"))
       
        attributedString.append(NSAttributedString(string: "Minimum Age: " + minAge + "\n"))
        attributedString.append(NSAttributedString(string: "Maximum Age: " + maxAge + "\n\n"))
        
        
        attributedString.append(NSAttributedString(string: "Contact Name:  " + contactName + "\n"))
        attributedString.append(NSAttributedString(string: "Phone: " + phone + "\n"))
        attributedString.append(NSAttributedString(string: "Country: " + country + "\n"))
        attributedString.append(NSAttributedString(string: "Location: " + location + "\n"))
        attributedString.append(NSAttributedString(string: "State: " + state + "\n"))
        attributedString.append(NSAttributedString(string: "Zip: " + zip + "\n"))
        
        // Set the attributed string to the titleTextView
        titleTextView?.attributedText = attributedString
    }
    
}
