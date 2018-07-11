//
//  PreAuthViewController.swift
//  chatTalk
//
//  Created by 한병두 on 2018. 7. 9..
//  Copyright © 2018년 Byungdoo Han. All rights reserved.
//

import UIKit

class PreAuthViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let authViewController = segue.destination as! AuthViewController
        if segue.identifier == "LoginSegue" {
            authViewController.isLogin = true
        }else {
            authViewController.isLogin = false
        }

    }
    

}
