//
//  MainViewController.swift
//  chatTalk
//
//  Created by 한병두 on 2018. 7. 9..
//  Copyright © 2018년 Byungdoo Han. All rights reserved.
//

import UIKit
import FirebaseAuth

class MainViewController: UIViewController {

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

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
