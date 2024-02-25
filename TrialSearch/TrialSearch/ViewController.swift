//
//  ViewController.swift
//  TrialSearch
//
//  Created by Admin on 1/25/24.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
   

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var searchButton: UIBarButtonItem!
    
    var studies: [Study] = []
    private var searchQuery = "heart attack"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = self.searchQuery
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let navyBlue = UIColor(red: 6.0/255.0, green: 24.0/255.0, blue: 51.0/255.0, alpha: 1.0)
        
        self.navigationController?.navigationBar.barTintColor = navyBlue
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        searchButton = UIBarButtonItem(title: "Search", style: .plain, target: self, action: #selector(searchButtonTapped))
        navigationItem.rightBarButtonItem = searchButton
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.searchQuery  = self.formatStudyName(searchQuery)
        
        fetchStudies()
        
        
    }
    
    
    
    @objc func searchButtonTapped() {
        let alert = UIAlertController(title: "Search Study", message: "Enter the keyword", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "keyword"
        }
        
        let searchAction = UIAlertAction(title: "Search", style: .default) { _ in
            if let textField = alert.textFields?.first, let searchQuery = textField.text {
                
                self.navigationController?.navigationBar.topItem?.title = searchQuery
                self.searchQuery = self.formatStudyName(searchQuery)
                
                self.fetchStudies()
                
            }
        }
        alert.addAction(searchAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }

    
    func formatStudyName(_ name: String) -> String {
        let words = name.components(separatedBy: " ")
        if words.count > 1 {
            return words.joined(separator: "+")
        } else {
            return name
        }
    }
    
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: studies[indexPath.item])
    }

    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studies.count
    }


    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudyCell", for: indexPath) as! StudyCell
        let study = studies[indexPath.row]
        cell.summaryLabel.numberOfLines = 0
        cell.summaryLabel.text = study.briefTitle.first
        cell.summaryLabel.text = (cell.summaryLabel.text ?? "Unkown Status") + "\n\n" + (study.status.first ?? "Unknown Status")
        
        return cell
    }

    

    func fetchStudies(){
        let url = URL(string: "https://classic.clinicaltrials.gov/api/query/study_fields?expr=\(searchQuery)&fields=BriefTitle%2COverallStatus%2CStartDate%2CCondition%2CHealthyVolunteers%2CBriefSummary%2CGender%2CCompletionDate%2CLocationCity%2CLocationContactEMail%2CLocationContactName%2CMinimumAge%2CLocationContactPhone%2CLocationContactRole%2CLocationCountry%2CLocationFacility%2CLocationState%2CLocationStatus%2CLocationZip%2CMaximumAge&min_rnk=1&max_rnk=100&fmt=json")!
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (200...299).contains(statusCode) else {
                print("❌ Response error: \(String(describing: response))")
                return
            }
            
            guard let data = data else {
                print("❌ Data is NIL")
                return
            }
            
            do {
                let apiResponse = try JSONDecoder().decode(Response.self, from: data)
                
                DispatchQueue.main.async { [weak self] in
                    // Filter studies with "Recruiting" OverallStatus
                    let recruitingStudies = apiResponse.studyFieldsResponse.studyFields.filter { ($0.status.contains("Recruiting") ||
                        $0.status.contains("Not yet recruiting")) &&
                        $0.country.contains("United States") }
                    
                    self?.studies = recruitingStudies
                    self?.tableView.reloadData()
                    
                    //print("✅ We got \(recruitingStudies.count) recruiting studies!")
                    //for study in recruitingStudies {
                        //print("🍏 Summary: \(study.briefTitle )")
                    //}
                }
                
            } catch {
                print("❌ Error decoding JSON: \(error.localizedDescription)")
            }
        }
        session.resume()
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "showDetail" {
            if let detailViewController = segue.destination as? DetailViewController,
               let study = sender as? Study {
                detailViewController.study = study
            }
        }
    }
    
    
    
}


