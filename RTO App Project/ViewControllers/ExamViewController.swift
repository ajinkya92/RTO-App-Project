//
//  ExamViewController.swift
//  RTO App Project
//
//  Created by Ajinkya Sonar on 14/08/18.
//  Copyright © 2018 Ajinkya Sonar. All rights reserved.
//

import UIKit
import Alamofire

class ExamViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var arrayData = NSArray()
    
    var tagSubstitute = 0
    
    var countdownTimer: Timer!
    var totalTime = 30
    
    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet weak var scoreAddLbl: UILabel!
    @IBOutlet weak var scoreReduceLbl: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getJsonData()
        startTimer()
        
    }
    
    
    @IBAction func nextQuestionButtonPressed(_ sender: UIButton) {
        
        changeToNextQuestion()
        
    }
    
    
    // Additional Required Methods for Answer Checking and UI Update
    
    func changeToNextQuestion() {
        
        if countdownTimer.isValid{
            countdownTimer.invalidate()
        }
        
        tagSubstitute += 1
        
        let indexPath = IndexPath(row: tagSubstitute, section: 0)
        
        collectionView.scrollToItem(at: indexPath, at: .right, animated: true)
        
        startTimer()
    }
    
    
}


// Mark: - Timer Functionality

extension ExamViewController {
    
    
    func startTimer() {
        totalTime = 30
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ExamViewController.updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        timerLbl.text = "\(timeFormatted(totalTime))"
        
        if totalTime != 0 {
            totalTime -= 1
        } else {
            endTimer()
        }
    }
    
    func endTimer() {
        countdownTimer.invalidate()
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        //     let hours: Int = totalSeconds / 3600
        return String(format: "%02d:%02d", minutes, seconds)
        
    }
    
    
    
}


// Mark: CollectionView Implementation

extension ExamViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrayData.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExamCollectionCell", for: indexPath) as! ExamCollectionCell
        
        
        cell.tableView.tag = indexPath.row
        
        tagSubstitute = cell.tableView.tag
        
        
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


// Mark: - TableView Method Implementation

extension ExamViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let individualData = arrayData.object(at: tagSubstitute) as! NSDictionary
        
        let option1 = individualData.value(forKey: "option_1") as! String
        let option2 = individualData.value(forKey: "option_2") as! String
        let option3 = individualData.value(forKey: "option_3") as! String
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExamOptionCell") as! ExamOptionCell
        
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let individualData = arrayData.object(at: tagSubstitute) as! NSDictionary
        let questions = individualData.value(forKey: "question") as! String
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExamQuestionCell") as! ExamQuestionCell
        
        cell.questionLbl.text = "Q.\(questions)"
        
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
    }
    
    
}



// Mark: Api Call with Alamofire
extension ExamViewController {
    
    func getJsonData() {
        
        Alamofire.request("http://mapi.trycatchtech.com/v1/rto/exam_question_list").responseJSON { (resopnse) in
            
            let jsonData = resopnse.result.value as! NSDictionary
            
            self.arrayData = jsonData.value(forKey: "data") as! NSArray
            
            
            DispatchQueue.main.async {
                
                self.collectionView.reloadData()
                
            }
            
            
        }
        
    }
    
}
