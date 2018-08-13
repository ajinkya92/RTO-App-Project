//
//  PracticeViewController.swift
//  RTO App Project
//
//  Created by Ajinkya Sonar on 11/08/18.
//  Copyright © 2018 Ajinkya Sonar. All rights reserved.
//

import UIKit
import Alamofire

class PracticeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    var jsonData = NSArray()
    
    var answerIsCorrect = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getJsonData()
    }

}

// Mark: - Collection View Implementation

extension PracticeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return jsonData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PracticeCollectionCell", for: indexPath) as! PracticeCollectionCell
        
        
        cell.tableView.tag = indexPath.row
        
        cell.tableView.delegate = nil
        cell.tableView.dataSource = nil
        
        cell.tableView.delegate = self
        cell.tableView.dataSource = self
        
        
        cell.tableView.reloadData()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.size.width, height: 400)
        
    }
    
    
}

// Mark: - Table View Implementation

extension PracticeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let individualData = jsonData.object(at: tableView.tag) as! NSDictionary
        
        let question = individualData.value(forKey: "question") as! String
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PracticeQuestionCell") as! PracticeQuestionCell
        
        cell.questionLbl.text = question
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //print("number is \(indexPath.row)")
        
        
        let individualData = jsonData.object(at:tableView.tag) as! NSDictionary
        
        let option1 = individualData.value(forKey: "option_1") as! String
        let option2 = individualData.value(forKey: "option_2") as! String
        let option3 = individualData.value(forKey: "option_3") as! String
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PracticeTableCell", for: indexPath) as! PracticeTableCell
        
        
        if indexPath.row == 0 {
            
            cell.optionLbl.text = "1. \(option1)"
            
        }
        
        else if indexPath.row == 1 {
            
            cell.optionLbl.text = "2. \(option2)"
            
        }
        
        else {
            
            cell.optionLbl.text = "3. \(option3)"
        }
        
        
        return cell
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Doubt - How can I show correct answer after clicking on wrong answer
        
        
        let individualData = jsonData.object(at:tableView.tag) as! NSDictionary
        
        let answers = individualData.object(forKey: "answer") as! String
        
        let selectedAnswer = (1 + indexPath.row)
        
        let myCell = tableView.cellForRow(at: indexPath) as! PracticeTableCell
        
        if selectedAnswer == Int(answers) {
            
            myCell.optionLbl.backgroundColor = UIColor.green
            answerIsCorrect = true
            
        }
        
        else {
            
            myCell.optionLbl.backgroundColor = UIColor.red
        }
        
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
        
    }
    
    
    
    
    
}



// Mark: - Json Call Implementation

extension PracticeViewController {
    
    func getJsonData() {
        
        Alamofire.request("http://mapi.trycatchtech.com/v1/rto/practice_question_list").responseJSON { (response) in
            
            self.jsonData = response.result.value as! NSArray
            
            DispatchQueue.main.async {
                
                self.collectionView.reloadData()
                
            }
            
        }
    
    }
    
}
