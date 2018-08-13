//
//  MainDisplayViewController.swift
//  RTO App Project
//
//  Created by Ajinkya Sonar on 18/07/18.
//  Copyright © 2018 Ajinkya Sonar. All rights reserved.
//

import UIKit

class MainDisplayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let titles = ["Question Bank", "Practice", "Exam", "Settings & Help"]
    let info = ["List of questions & answers and meaning of road signs", "Test your knowledge without worrying about time", "Time and questions bound test exactly same as actual RTO test", "Language selection, forms, RTO office information and more"]
    let displayImages = [#imageLiteral(resourceName: "Practice"), #imageLiteral(resourceName: "QuestionBank"), #imageLiteral(resourceName: "exam"), #imageLiteral(resourceName: "settings")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
/*** Mark: TableView Methods ***/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainDisplayTableViewCell") as! MainDisplayTableViewCell
        
        cell.DisplayImage.image = displayImages[indexPath.row]
        cell.DisplayTitle.text = titles[indexPath.row]
        cell.DisplayInfo.text = info[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            let QuestionBankViewController = storyboard?.instantiateViewController(withIdentifier: "QuestionBankViewController")
            
            self.navigationController?.pushViewController(QuestionBankViewController!, animated: true)
        }
    }

}
