//
//  AuthViewController.swift
//  chatTalk
//
//  Created by 한병두 on 2018. 7. 9..
//  Copyright © 2018년 Byungdoo Han. All rights reserved.
//

import UIKit
import FirebaseAuth

class AuthViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBAction func buttonPressed(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
