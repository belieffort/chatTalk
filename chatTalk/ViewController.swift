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

    var targetEmail:String?
    var targetUID:String?
    
    @IBAction func sendButtonPressed(_ sender: Any) {
        var mdata = [String:String]()
        mdata["text"] = chatTextView.text
        mdata["sender"] = Auth.auth().currentUser!.uid
        mdata["receiver"] = targetUID
        // Push data to Firebase Database
        self.ref.child("messages").childByAutoId().setValue(mdata)
        chatTextView.text = nil
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureDatabase()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue cell
        let cell = self.chatTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        // Unpack message from Firebase DataSnapshot
        let messageSnapshot: DataSnapshot! = self.messages[indexPath.row]
        guard let message = messageSnapshot.value as? [String:String] else { return cell }
        let sender = message["sender"]
        var text = "[text]"
        if sender == targetUID {
            text = "\(targetEmail!) : \(message["text"]!)"
        } else {
            text = "Me : \(message["text"]!)"
        }
        

        cell.textLabel?.text = text
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    deinit {
        if let refHandle = _refHandle {
            self.ref.child("messages").removeObserver(withHandle: refHandle)
        }
    }
    
    
    func configureDatabase() {
        ref = Database.database().reference()
        // Listen for new messages in the Firebase database
        _refHandle = self.ref.child("messages")
//특정 항목만 불러오기
//            .queryOrdered(byChild: "text")
//            .queryEqual(toValue: "Sleep tight")
            .observe(.childAdded, with: { [weak self] (snapshot) -> Void in
            guard let strongSelf = self else { return }
                
            let messageSnapshot: DataSnapshot! = snapshot
            guard let message = messageSnapshot.value as? [String:String] else { return }
//            let text = message["text"] ?? "[text]"
                let sender = message["sender"]
                let receiver = message["receiver"]
                if (sender == strongSelf.targetUID || sender == Auth.auth().currentUser!.uid) && (receiver == strongSelf.targetUID || receiver == Auth.auth().currentUser!.uid) {
                    strongSelf.messages.append(snapshot)
                    strongSelf.chatTableView.insertRows(at: [IndexPath(row: strongSelf.messages.count-1, section: 0)], with: .automatic)
                    }
            
        })
    }


}

