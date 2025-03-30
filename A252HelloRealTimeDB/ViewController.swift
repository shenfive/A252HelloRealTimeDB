//
//  ViewController.swift
//  A252HelloRealTimeDB
//
//  Created by 申潤五 on 2025/3/30.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

struct User{
    var age : Int
    var name : String
}


class ViewController: UIViewController {
    
    var ref:DatabaseReference!

    @IBOutlet weak var theLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Auth.auth().addStateDidChangeListener { auth, user in
            if user == nil {
                print("尚未登入")
                auth.signInAnonymously()
            }else{
                print("已登入")
            }
        }
        
        ref = Database.database().reference().child("users")
        
        
        //簡單寫入讀取
//        ref.setValue(ServerValue.timestamp())
        
        
        //持續讀取
        ref.child("test").observe(.value) { snapshot in
            let data = snapshot.value as? String
            self.theLabel.text = data
        }
//        ref.observe(of: .value) { snapshot in
//            let data = snapshot.value as! String
//            print(data)
//        }
        
        
        
        
    }


    @IBAction func addRecord(_ sender: Any) {
        
        ref.child("test2").childByAutoId().setValue(ServerValue.timestamp())
    }
}

