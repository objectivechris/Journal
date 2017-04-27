//
//  EntriesTableViewController.swift
//  Journal
//
//  Created by Christopher Rene on 4/26/17.
//  Copyright © 2017 Christopher Rene. All rights reserved.
//

import UIKit

class EntriesTableViewController: UITableViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var entries: [Entry] = []
    
    let cellIdentifier = "EntryCell"
    
    func fetchData() {
        do {
            entries = try context.fetch(Entry.fetchRequest())
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
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let cellNib = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: cellIdentifier)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return entries.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! EntryCell

        // Configure the cell...
        let date = entries.reversed()[indexPath.row].date
        let time = entries.reversed()[indexPath.row].time
        
        cell.titleLabel.text = entries.reversed()[indexPath.row].title
        cell.bodyLabel.text = entries.reversed()[indexPath.row].body
        
        if let date = date, let time = time {
            let timestamp = "\(date) - \(time)"
            cell.dateLabel.text = timestamp
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
 
            let entry = self.entries[indexPath.row]
            self.context.delete(entry)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            self.entries.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
        
        let share = UITableViewRowAction(style: .default, title: "Share") { (action, indexPath) in
            print("Share")
        }
        
        delete.backgroundColor = UIColor(red: 0/255, green: 177/255, blue: 106/255, alpha: 1.0)
        share.backgroundColor = UIColor(red: 54/255, green: 215/255, blue: 183/255, alpha: 1.0)
        
        
        return [delete,share]
    }
}
