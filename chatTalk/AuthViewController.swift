//
//  AuthViewController.swift
//  chatTalk
//
//  Created by 한병두 on 2018. 7. 9..
//  Copyright © 2018년 Byungdoo Han. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class AuthViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var isLogin:Bool?
    var ref: DatabaseReference!

    
    @IBAction func buttonPressed(_ sender: Any) {
        
        if isLogin! {
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (_, error) in
                if (error == nil) {
                    self.performSegue(withIdentifier: "ToMain", sender: sender)
                }
            })
        }else {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                if (error == nil) {
                    self.performSegue(withIdentifier: "ToMain", sender: sender)
//                    let mdata = [
//                        user!.user.uid : ["email" : user!.user.email]
//
//                    ]
//                    self.ref.child("users").childByAutoId().setValue(mdata)
                    let mdata = ["email" : user!.user.email]
                    self.ref.child("users/\(user!.user.uid)").setValue(mdata)



                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()

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
