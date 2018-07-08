//
//  ViewController.swift
//  chatTalk
//
//  Created by 한병두 on 2018. 7. 8..
//  Copyright © 2018년 Byungdoo Han. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var chatTextView: UITextView!

    var ref: DatabaseReference!
    var messages: [DataSnapshot]! = []
    var _refHandle: DatabaseHandle?

    
    
    @IBAction func sendButtonPressed(_ sender: Any) {
        var mdata = [String:String]()
        mdata["text"] = chatTextView.text

        
        // Push data to Firebase Database
        self.ref.child("messages").childByAutoId().setValue(mdata)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureDatabase()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    deinit {
//        if let refHandle = _refHandle {
//            self.ref.child("messages").removeObserver(withHandle: _refHandle)
//        }
    }
    
    
    func configureDatabase() {
        ref = Database.database().reference()
        // Listen for new messages in the Firebase database
//        _refHandle = self.ref.child("messages").observe(.childAdded, with: { [weak self] (snapshot) -> Void in
//            guard let strongSelf = self else { return }
//            strongSelf.messages.append(snapshot)
//            strongSelf.clientTable.insertRows(at: [IndexPath(row: strongSelf.messages.count-1, section: 0)], with: .automatic)
//        })
    }


}

