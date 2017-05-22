//
//  AddEntryViewController.swift
//  Journal
//
//  Created by Christopher Rene on 4/26/17.
//  Copyright © 2017 Christopher Rene. All rights reserved.
//

import UIKit

class AddEntryViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var entryBodyTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        
        guard let enteredText = entryBodyTextView.text else { return }
        guard let titleText = titleTextField.text else { return }
        
        if enteredText.isEmpty || entryBodyTextView.text == "Type anything..." || titleText.isEmpty || titleTextField.placeholder == "Enter Title" {
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
            
            guard let titleText = titleTextField.text else { return }
            guard let bodyText = entryBodyTextView.text else { return }
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let newEntry = Entry(context: context)
            newEntry.title = titleText
            newEntry.body = bodyText
            newEntry.date = currentDate
            newEntry.time = currentTime
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = .black
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        textField.placeholder = ""
        textField.textColor = .black
    }
}

