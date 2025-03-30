//
//  Page3ViewController.swift
//  A252HelloRealTimeDB
//
//  Created by 申潤五 on 2025/3/30.
//

import UIKit
import Firebase

struct Content{
    var date:Date
    var nickName:String
    var content:String
}



class Page3ViewController: UIViewController {

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var theTableView: UITableView!
    
    
    var nickName = ""
    var subject:SubjectData!
    
    var displayContent : [Content] = []
    
    var ref:DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference().child("users/dis")
        
        print(nickName)
        title = subject.subject
        // Do any additional setup after loading the view.
        
        
        theTableView.delegate = self
        theTableView.dataSource = self
        
        let nib = UINib(nibName: "Page2TableViewCell", bundle: nil)
        theTableView.register(nib, forCellReuseIdentifier: "page2TableViewCell")
        
        
        //讀資料
        ref.child(subject.key).observe(.value) { snapshot in
            self.displayContent.removeAll()
            snapshot.children.forEach { child in
                if let childSnapshot = child as? DataSnapshot {
                    var newContent = Content(date: Date(), nickName: "", content: "")
                    if let content = childSnapshot.childSnapshot(forPath: "content").value as? String{
                        newContent.content = content
                    }
                    
                    if let nickname = childSnapshot.childSnapshot(forPath: "nickname").value as? String{
                        newContent.nickName = nickname
                    }
                    
                    if let dateInt = childSnapshot.childSnapshot(forPath: "content").value as? Int{
                        newContent.date = Date(timeIntervalSince1970: TimeInterval(dateInt / 1000))
                    }
                    self.displayContent.append(newContent)
                    
                }
            }
            print(self.displayContent.count)
            self.theTableView.reloadData()
        }
        
        
        
        
        
        
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
extension Page3ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        displayContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "page2TableViewCell") as! Page2TableViewCell
        cell.subject.text = displayContent[indexPath.row].content
        cell.lastUser.text = displayContent[indexPath.row].nickName
        
        let formater = DateFormatter()
        formater.dateFormat = "MM-dd HH:mm:ss"
        cell.lastDate.text = formater.string(from: displayContent[indexPath.row].date)
        
        
//        cell.textLabel?.text = displayList[indexPath.row].subject
        
        
        
        return cell
    }
    
}
