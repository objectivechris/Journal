//
//  UpdateEntryViewController.swift
//  Journal
//
//  Created by Rene, Christopher (CAI - Atlanta) on 5/22/17.
//  Copyright © 2017 Christopher Rene. All rights reserved.
//

import UIKit

class UpdateEntryViewController: UIViewController {
    
    @IBOutlet weak var entryBodyTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    
    var entry: Entry!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configureEntryData(entry: entry)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func configureEntryData(entry: Entry) {
        entryBodyTextView.text = entry.body ?? "Nothing to update."
    }
    
    @IBAction func update(_ sender: Any) {
        guard let newEntry = entryBodyTextView.text else { return }
        
        entry.body = newEntry
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        dismiss(animated: true, completion: nil)
    }
}
