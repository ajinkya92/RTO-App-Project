//
//  QuestionBankViewController.swift
//  RTO App Project
//
//  Created by Ajinkya Sonar on 19/07/18.
//  Copyright © 2018 Ajinkya Sonar. All rights reserved.
//

import UIKit
import Kingfisher

class QuestionBankViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var textDataArray = NSArray()
    var imageDataArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getTextData()
        getImageData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segmentControlPressed(_ sender: UISegmentedControl) {
        
        tableView.reloadData()
        
    }
    
/*** Mark: Table View Delegate and Data Source ***/
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if segment.selectedSegmentIndex == 0 {
            return 250
        }
        else {
            return 200
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if segment.selectedSegmentIndex == 0 {
            return UITableViewAutomaticDimension
        }
        else {
            return 200
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if segment.selectedSegmentIndex == 0 {
           return textDataArray.count
        }
        else {
            return imageDataArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if segment.selectedSegmentIndex == 0 {
            
            let questions = textDataArray.value(forKey: "question") as! NSArray
            let individualQuestion = questions.object(at: indexPath.row) as! String
            let answers = textDataArray.value(forKey: "answer") as! NSArray
            let individualAnswer = answers.object(at: indexPath.row) as! String
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionBankTextCell") as! QuestionBankTextCell
            
            cell.questionText.text = individualQuestion
            cell.answerText.text = individualAnswer
            
            return cell
        }
        else {
            
            let displayImageLinks = imageDataArray.value(forKey: "image") as! NSArray
            let individualImageLink = displayImageLinks.object(at: indexPath.row)
            let displayImageTexts = imageDataArray.value(forKey: "name") as! NSArray
            let individualImageText = displayImageTexts.object(at: indexPath.row) as! String
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionBankImageCell") as! QuestionBankImageCell
            
            let url = URL(string: individualImageLink as! String)
            
            cell.displayImage.kf.setImage(with: url)
            cell.displayImageText.text = individualImageText
            
            return cell
            
        }
        
    }

}



extension QuestionBankViewController {
    
    /*** Mark: API Call ***/
    
    func getTextData() {
        
        let url = URL(string: "http://mapi.trycatchtech.com/v1/rto/text_question_list")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                print(error?.localizedDescription ?? "")
            }
            else {
                
                do{
                    self.textDataArray = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSArray
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                } catch{
                    print("Exception in getting data online")
                }
            }
            
            }.resume()
        
    }
    
    func getImageData() {
        
        let url = URL(string: "http://mapi.trycatchtech.com/v1/rto/image_question_list")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                print(error?.localizedDescription ?? "")
            }
            else {
                
                do{
                    self.imageDataArray = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSArray
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                } catch{
                    print("Exception in getting data online")
                }
            }
            
            }.resume()
        
    }
    
    
    
}
