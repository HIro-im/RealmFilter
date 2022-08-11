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
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let allData = realm.objects(Filter.self)
        print("すべてのデータ\(allData)")
        
        
    }

    
    @IBAction func registerButton(_ sender: Any) {
        let user = Filter()
        user.text = textField.text!
        user.selectedButton = selectedSegment.selectedSegmentIndex
        try! realm.write {
            realm.add(user)
        }
        
        textField.text = ""
        let allData = realm.objects(Filter.self)
        print("すべてのデータ\(allData)")

        let leftData = realm.objects(Filter.self).filter("selectedButton == %@", 0)
        print("左のデータ\(leftData)")
        
        let rightData = realm.objects(Filter.self).filter("selectedButton == %@", 1)
        print("右のデータ\(rightData)")

    }
    
    
    @IBAction func comfirmButton(_ sender: Any) {
        
    }
    
}

