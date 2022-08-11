//
//  ViewController.swift
//  RealmFilter
//
//  Created by 今橋浩樹 on 2022/08/10.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var selectedSegment: UISegmentedControl!    
    @IBOutlet weak var alertText: UILabel!
    
    let realm = try! Realm()
    
    var currentLeftDataCount: Int = 0
    var currentRightDataCount: Int = 0
    let saveLimit: Int = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let allData = realm.objects(Filter.self)
        print("すべてのデータ\(allData)")
        
        currentCounterUpdate()
        
    }

    func currentCounterUpdate() {
        let leftData = realm.objects(Filter.self).filter("selectedButton == %@", 0)
        print("左のデータ\(leftData)")
        currentLeftDataCount = leftData.count
        print(currentLeftDataCount)
        
        let rightData = realm.objects(Filter.self).filter("selectedButton == %@", 1)
        print("右のデータ\(rightData)")
        currentRightDataCount = rightData.count
        print(currentRightDataCount)

        
    }
    
    @IBAction func registerButton(_ sender: Any) {
        
        switch selectedSegment.selectedSegmentIndex {
        case Timing.Lunch.rawValue:
            if currentLeftDataCount >= saveLimit {
                alertText.text = "登録限界です： \(selectedSegment.titleForSegment(at: selectedSegment.selectedSegmentIndex)!)"
                return
            }
            
        case Timing.Dinner.rawValue:
            if currentRightDataCount >= saveLimit {
                alertText.text = "登録限界です： \(selectedSegment.titleForSegment(at: selectedSegment.selectedSegmentIndex)!)"
                return
            }
            
        default:
            print("another")
        }
        
        let user = Filter()
        user.text = textField.text!
        user.selectedButton = selectedSegment.selectedSegmentIndex
        try! realm.write {
            realm.add(user)
        }
        
        textField.text = ""
        let allData = realm.objects(Filter.self)
        print("すべてのデータ\(allData)")
        
        currentCounterUpdate()
        
    }
    
    
    @IBAction func comfirmButton(_ sender: Any) {
        
    }
    
}

