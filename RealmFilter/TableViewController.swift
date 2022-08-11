//
//  TableViewController.swift
//  RealmFilter
//
//  Created by 今橋浩樹 on 2022/08/11.
//

import UIKit
import RealmSwift

enum Timing: Int {
    case Lunch = 0
    case Dinner = 1
    
}

enum selectedTab: Int {
    case isBook = 1
    case isRated = 2
    
}

class TableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let realm = try! Realm()
    
    var selectIfTiming: Int = 0
    
    var filtData: Results<Filter>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self

        switch navigationController?.tabBarItem.tag {
        case selectedTab.isBook.rawValue:
            selectIfTiming = Timing.Lunch.rawValue
        case selectedTab.isRated.rawValue:
            selectIfTiming = Timing.Dinner.rawValue
        default:
            print("another")
        }
        
        filtData = getData(selectIfTiming)
        
        // Do any additional setup after loading the view.
    }
    
    func getData(_ selectTab: Int) -> Results<Filter> {
        let filterData = realm.objects(Filter.self).filter("selectedButton == %@", selectTab)
        return filterData
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

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let counter = filtData?.count {
            return counter
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        // ここを強制アンラップにしない方法はないか
        cell.textLabel?.text = filtData?[indexPath.row].text
        return cell
        // Cellに表示するのは配列の中身で、indexPath.rowを要素数にして引き出した値をCellに当てはめている
        // Cellは入れ物で、配列とindexPathが紐付いているので、選択時のindexPath.rowがわかれば、そのデータが取れる
    }
    
    
}

