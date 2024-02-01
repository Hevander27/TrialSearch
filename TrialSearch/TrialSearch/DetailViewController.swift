//
//  DetailViewController.swift
//  TrialSearch
//
//  Created by Admin on 1/29/24.
//

import Foundation
import UIKit




class DetailViewController: UIViewController {
    var study: ResearchStudy?
    
    
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var summaryTextView: UITextView!
    @IBOutlet weak var statusTextView: UITextView!
    @IBOutlet weak var healthyTextView: UITextView!
    @IBOutlet weak var genderTextView: UITextView!
    @IBOutlet weak var completeDateTextView: UITextView!
    @IBOutlet weak var cityTextView: UITextView!
    @IBOutlet weak var contactEmailTextView: UITextView!
    @IBOutlet weak var contactNameTextView: UITextView!
    @IBOutlet weak var contactRoleTextView: UITextView!
    @IBOutlet weak var countryTextView: UITextView!
    @IBOutlet weak var locationFacilityTextView: UITextView!
    @IBOutlet weak var locationStateTextView: UITextView!
    @IBOutlet weak var locationStatusTextView: UITextView!
    @IBOutlet weak var locationZipTextView: UITextView!
    @IBOutlet weak var maximumAgeTextView: UITextView!
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureView()
        
    }
    
    
    func configureView() { 
        
        guard let study = study else {
            print("Unable to get caption.")
            return
        }
        titleTextView.text = study.briefTitle.first ?? ""
        statusTextView.text = study.status.first ?? ""
        healthyTextView.text = study.startDate.first ?? ""
        
        
    }
    
}
