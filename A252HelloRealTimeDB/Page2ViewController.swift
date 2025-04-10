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
    var lastUserName:String
    var key:String
}

class Page2ViewController: UIViewController {
    @IBOutlet weak var theTableView: UITableView!
    
    var nickName = ""
    
    var ref:DatabaseReference!
    
    var displayList:[SubjectData] = []
    
    var selectedSubjectData:SubjectData?

    override func viewDidLoad() {
        super.viewDidLoad()
        print(nickName)
        
        theTableView.delegate = self
        theTableView.dataSource = self
        
        let nib = UINib(nibName: "Page2TableViewCell", bundle: nil)
        theTableView.register(nib, forCellReuseIdentifier: "page2TableViewCell")

        let ref = Database.database().reference().child("users/subject")
        ref.observeSingleEvent(of: .value) { snapshot in
            self.displayList.removeAll()
            snapshot.children.forEach { child in
                if let data = child as? DataSnapshot{
                    var subjectData = SubjectData.init(subject: "", lastUpdate: Date(), lastUserName: "",key: "")
                    if let subject = data.childSnapshot(forPath: "subject").value as? String{
                        subjectData.subject = subject
                    }
                    
                    if let lastUpdateTime = data.childSnapshot(forPath: "lastupdate").value as? Int{
                        subjectData.lastUpdate = Date(timeIntervalSince1970: TimeInterval(lastUpdateTime / 1000))
                    }
                    if let lastUpdateUserNickname = data.childSnapshot(forPath: "lastUserName").value as? String{
                        subjectData.lastUserName = lastUpdateUserNickname
                    }
                    
                    subjectData.key = data.key
                    
                    
                    self.displayList.append(subjectData)
                }
            }
            print(self.displayList)
            self.theTableView.reloadData()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            case "goPage3":
            let nextVC = segue.destination as! Page3ViewController
            nextVC.subject = selectedSubjectData!
            nextVC.nickName = nickName
        default:
            break
        }
    }
    
    
}

extension Page2ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        displayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "page2TableViewCell") as! Page2TableViewCell
        cell.subject.text = displayList[indexPath.row].subject
        cell.lastUser.text = displayList[indexPath.row].lastUserName
        
        let formater = DateFormatter()
        formater.dateFormat = "MM-dd HH:mm:ss"
        cell.lastDate.text = formater.string(from: displayList[indexPath.row].lastUpdate) + ":\( displayList[indexPath.row].key)"
        
        
//        cell.textLabel?.text = displayList[indexPath.row].subject
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedSubjectData = displayList[indexPath.row]
        performSegue(withIdentifier: "goPage3", sender: self)
    }
    
}
