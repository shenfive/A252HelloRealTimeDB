//
//  ViewController.swift
//  A252HelloRealTimeDB
//
//  Created by 申潤五 on 2025/3/30.
//

import UIKit
import FirebaseAuth


class ViewController: UIViewController {
    @IBOutlet weak var theNickNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.auth().addStateDidChangeListener { auth, user in
            if user == nil {
                auth.signInAnonymously()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "goPage2":
            let nextVC = segue.destination as! Page2ViewController
            //TODO:檢查名字正確性
            nextVC.nickName = self.theNickNameTextField.text ?? ""
        default:
            break
        }
    }


    @IBAction func goPage2(_ sender: Any) {
        let nickName = self.theNickNameTextField.text ?? "Anonymous"
        performSegue(withIdentifier: "goPage2", sender: self)
    }
    
 
    
    
    
    
}

