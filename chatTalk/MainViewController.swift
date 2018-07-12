//
//  MainViewController.swift
//  chatTalk
//
//  Created by 한병두 on 2018. 7. 9..
//  Copyright © 2018년 Byungdoo Han. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var ref: DatabaseReference!
    var users: [DataSnapshot]! = []
    var _refHandle: DatabaseHandle?
    
    @IBOutlet weak var userTableView: UITableView!
    @IBOutlet weak var emailLabel: UILabel!
    var handle:AuthStateDidChangeListenerHandle?
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        do {
           try Auth.auth().signOut()
            self.navigationController?.popToRootViewController(animated: true)
        } catch {
            print("Signout failed")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       handle = Auth.auth().addStateDidChangeListener() { (auth, user) in
            if let user = auth.currentUser {
                self.emailLabel.text = user.email
            } else {
                self.emailLabel.text = "로그아웃 되었습니다"
            }
        }
        configureDatabase()

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue cell
        let cell = self.userTableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        // Unpack message from Firebase DataSnapshot
        let userSnapshot: DataSnapshot! = self.users[indexPath.row]
        guard let user = userSnapshot.value as? [String:String] else { return cell }
        let text = user["email"] ?? "[email]"
        cell.textLabel?.text = text
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ChatDetailSegue", sender: self)
    }
    
    deinit {
        if let refHandle = _refHandle {
            self.ref.child("users").removeObserver(withHandle: refHandle)
        }
    }
    
    
    func configureDatabase() {
        ref = Database.database().reference()
        // Listen for new messages in the Firebase database
        _refHandle = self.ref.child("users")
            //특정 항목만 불러오기
            //            .queryOrdered(byChild: "text")
            //            .queryEqual(toValue: "Sleep tight")
            .observe(.childAdded, with: { [weak self] (snapshot) -> Void in
                guard let strongSelf = self else { return }
                strongSelf.users.append(snapshot)
                strongSelf.userTableView.insertRows(at: [IndexPath(row: strongSelf.users.count-1, section: 0)], with: .automatic)
            })
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let userSnapshot: DataSnapshot! = self.users[userTableView.indexPathForSelectedRow!.row]
        guard let user = userSnapshot.value as? [String:String] else { return  }

        
        let viewController = segue.destination as! ViewController
        viewController.targetEmail = user["email"] ?? "[email]"
        viewController.targetUID = userSnapshot.key
        
        
    }


}
