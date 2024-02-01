//
//  ViewController.swift
//  TrialSearch
//
//  Created by Admin on 1/25/24.
//

import UIKit

class ViewController: UIViewController {
    
    private static let cellReuseID = "CellID"
    
    private var researchStudies = [ResearchStudy]()
    private var tableView = UITableView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        ResearchStudy.getResearchStudies(handleCompletion: { [weak self]
            researchStudies in
            self?.researchStudies = researchStudies
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ViewController.cellReuseID)
        tableView.delegate = self
        tableView.dataSource = self
        layoutTableView()
    }
    
    private func layoutTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView) // Corrected from didAddSubview to addSubview
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        researchStudies[indexPath.row]
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        researchStudies.count
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ViewController.cellReuseID, for: indexPath)
        cell.contentConfiguration = cellConfiguration(from: researchStudies[indexPath.row])
        return cell
    }
    
    private func cellConfiguration(from researchStudy: ResearchStudy) -> UIListContentConfiguration {
        var cellConfiguration = UIListContentConfiguration.subtitleCell()
        cellConfiguration.text = researchStudy.briefTitle.first!
        cellConfiguration.secondaryText = researchStudy.status.first! + ", starts " + researchStudy.startDate.first!
        return cellConfiguration
    }
    
}
