//
//  TableViewController.swift
//  RealmFilter
//
//  Created by 今橋浩樹 on 2022/08/11.
//

import UIKit
import RealmSwift


class TableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let realm = try! Realm()
    
    var selectIfTiming: Int = 0
    
    var filtData: Results<Filter>?
    
    override func viewDidLoad() {
        
        // 挙動観測のための一文
        print("table viewDidLoad")
        super.viewDidLoad()
        notificationD()
        self.tableView.delegate = self
        self.tableView.dataSource = self

        setTiming()
        
        filtData = getData(selectIfTiming)
        
        // Do any additional setup after loading the view.
    }
    
    func getData(_ selectTab: Int) -> Results<Filter> {
        let filterData = realm.objects(Filter.self).filter("selectedButton == %@", selectTab)
        return filterData
    }
    
    func setTiming() {
        switch navigationController?.tabBarItem.tag {
        case selectedTab.isBook.rawValue:
            selectIfTiming = Timing.Lunch.rawValue
        case selectedTab.isRated.rawValue:
            selectIfTiming = Timing.Dinner.rawValue
        default:
            print("another")
        }
    }
    
    func notificationD() {
        
        UNUserNotificationCenter.current().getDeliveredNotifications { (notification) in
            if notification.isEmpty {
                return
            }
            if notification[0].request.identifier == "Lunch"  {
                print("Lunch notification")
                self.selectIfTiming = Timing.Lunch.rawValue
            } else {
                print("Dinner notification")
                self.selectIfTiming = Timing.Dinner.rawValue
            }
        }
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 挙動観測のための一文
        print("table viewWillAppear")
        
        // realm内のテーブルを取り出して、メンバ変数への格納と件数を取得する
        setTiming()
        filtData = getData(selectIfTiming)
        
        // リストビューを再読込する
        tableView.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // 挙動観測のための一文
        print("table viewDidAppear")

    }

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

