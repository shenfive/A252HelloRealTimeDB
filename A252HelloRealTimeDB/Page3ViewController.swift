//
//  Page3ViewController.swift
//  A252HelloRealTimeDB
//
//  Created by 申潤五 on 2025/3/30.
//

import UIKit
import Firebase


class Page3ViewController: UIViewController {

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var theTableView: UITableView!
    
    
    var nickName = ""
    var subject:SubjectData!
    
    var ref:DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference().child("users/dis")
        
        print(nickName)
        title = subject.subject
        // Do any additional setup after loading the view.
    }
    
    @IBAction func newMesage(_ sender: Any) {
        let data = ["content":inputTextField.text ?? "",
                    "nickname":nickName,
                    "timestemp":ServerValue.timestamp()] as [String : Any]
        ref.child(subject.key).childByAutoId().setValue(data)
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
