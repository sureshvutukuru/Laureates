//
//  ResultsTableViewController.swift
//  Laureates
//
//  Created by Suresh Vutukuru on 19/12/20.
//  Copyright © 2020 Suresh Vutukuru. All rights reserved.
//

import UIKit

class ResultsTableViewController: UITableViewController {
    
    var laureates = [Laureate]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Top Nobel Laureates"
        tableView.estimatedRowHeight = 68.0
        tableView.rowHeight = UITableView.automaticDimension
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return laureates.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LaureateCell", for: indexPath)
        
        let laureate = laureates[indexPath.section]
        cell.textLabel?.text = "Category : \(laureate.category)\nName : \(laureate.name)\nPlace: \(laureate.country)\nMotivation : \(laureate.motivation.stripped.firstUppercased)"
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    // MARK: - Table view delegates
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let laureate = laureates[section]
        return laureate.firstname+" "+laureate.surname+", "+laureate.year
    }
}
