//
//  UpdateEntryViewController.swift
//  Journal
//
//  Created by Rene, Christopher (CAI - Atlanta) on 5/22/17.
//  Copyright © 2017 Christopher Rene. All rights reserved.
//

import UIKit

class UpdateEntryViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var entryBodyTextView: UITextView!
    @IBOutlet weak var updateTitleTextField: UITextField!
    
    var entry: Entry!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        entryBodyTextView.textColor = .black
        configureEntryData(entry: entry)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func configureEntryData(entry: Entry) {
        updateTitleTextField.text = entry.title
        entryBodyTextView.text = entry.body ?? "Nothing to update."
    }
    
    @IBAction func update(_ sender: Any) {
        guard let newEntry = entryBodyTextView.text else { return }
        guard let updateTitleText = updateTitleTextField.text else { return }
        
        if newEntry.isEmpty || entryBodyTextView.text == "Type anything..." || updateTitleText.isEmpty || updateTitleTextField.placeholder == "Enter Title" {
            let alert = UIAlertController(title: "Please type something", message: "Your entry or title was left blank.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                
            }))
            
            present(alert, animated: true, completion: nil)
            
        } else {
            
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM d, yyyy"
            let currentDate = formatter.string(from: date)
            
            let timeFormatter = DateFormatter()
            timeFormatter.timeStyle = .short
            let currentTime = timeFormatter.string(from: date)
            
            entry.title = updateTitleText
            entry.body = newEntry
            entry.date = currentDate
            entry.time = currentTime
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            dismiss(animated: true, completion: nil)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = ""
        textField.textColor = .black
    }
}
