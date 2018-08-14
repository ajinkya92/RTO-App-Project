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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getJsonData()
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
        
        let individualData = arrayData.object(at: tableView.tag) as! NSDictionary
        
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
        
        let individualData = arrayData.object(at: tableView.tag) as! NSDictionary
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
