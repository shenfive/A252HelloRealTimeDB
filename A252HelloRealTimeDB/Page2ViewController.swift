//
//  Page2ViewController.swift
//  A252HelloRealTimeDB
//
//  Created by 申潤五 on 2025/3/30.
//

import UIKit
import Firebase
import FirebaseDatabase

struct SubjectData:Codable{
    var subject:String
    var lastUpdate:Date
    var lastUuserName:String
}

class Page2ViewController: UIViewController {
    @IBOutlet weak var theTableView: UITableView!
    
    var nickName = ""
    
    var ref:DatabaseReference!
    
    var displayList:[SubjectData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        print(nickName)
        
        theTableView.delegate = self
        theTableView.dataSource = self

        let ref = Database.database().reference().child("users/subject")
        ref.observeSingleEvent(of: .value) { snapshot in
            self.displayList.removeAll()
            snapshot.children.forEach { child in
                if let data = child as? DataSnapshot{
                    var subjectData = SubjectData.init(subject: "", lastUpdate: Date(), lastUuserName: "")
                    if let subject = data.childSnapshot(forPath: "subject").value as? String{
                        subjectData.subject = subject
                    }
                    
                    if let lastUpdateTime = data.childSnapshot(forPath: "lastupdate").value as? Int{
                        subjectData.lastUpdate = Date(timeIntervalSince1970: TimeInterval(lastUpdateTime / 1000))
                    }
                    if let lastUpdateUserNickname = data.childSnapshot(forPath: "lastUserName").value as? String{
                        subjectData.lastUuserName = lastUpdateUserNickname
                    }
                    self.displayList.append(subjectData)
                }
            }
            print(self.displayList)
            self.theTableView.reloadData()
        }
        
    }
}

extension Page2ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        displayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = displayList[indexPath.row].subject
        return cell
    }
    
    
}
