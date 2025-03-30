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
        
//        ref.observeSingleEvent(of: .value) { snapshot in
//            let time = snapshot.value as! Double
//            let date = Date(timeIntervalSince1970: time / 1000)
//            print(date)
//        }
        
        
        
        
    }


    @IBAction func addRecord(_ sender: Any) {
        
        ref.child("test2").childByAutoId().setValue(ServerValue.timestamp())
    }
}

