//
//  EntriesTableViewController.swift
//  Journal
//
//  Created by Christopher Rene on 4/26/17.
//  Copyright © 2017 Christopher Rene. All rights reserved.
//

import UIKit

class EntriesTableViewController: UITableViewController, UISearchBarDelegate {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var entries: [Entry] = []
    var selectedIndex: Int!
    
    var filteredData: [Entry] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let cellIdentifier = "EntryCell"
    
    func fetchData() {
        do {
            entries = try context.fetch(Entry.fetchRequest())
            filteredData = entries.reversed()
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print("Couldn't retrieve entries.")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        
        let cellNib = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: cellIdentifier)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "updateVC" {
            let updateVC = segue.destination as! UpdateEntryViewController
            updateVC.entry = filteredData[selectedIndex!]
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! EntryCell

        // Configure the cell...
        let date = filteredData[indexPath.row].date
        let time = filteredData[indexPath.row].time
        
        cell.titleLabel.text = filteredData[indexPath.row].title
        cell.bodyLabel.text = filteredData[indexPath.row].body
        
        if let date = date, let time = time {
            let timestamp = "\(date) - \(time)"
            cell.dateLabel.text = timestamp
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "updateVC", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
 
            let entry = self.filteredData[indexPath.row]
            self.context.delete(entry)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            self.filteredData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
        
        let share = UITableViewRowAction(style: .default, title: "Share") { (action, indexPath) in
            print("Share")
        }
        
        delete.backgroundColor = UIColor(red: 0, green: 177, blue: 106)
        share.backgroundColor = UIColor(red: 54, green: 215, blue: 183)

        return [delete,share]
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredData = entries.reversed()
        } else {
            filteredData = entries.filter { ($0.title?.lowercased().contains(searchText.lowercased()))! }
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
