//
//  ViewController.swift
//  Test
//
//  > Created by user188220 on 3/16/21.
//

import UIKit

class ViewController: UIViewController {
    
    let arrEvents = ["event1", "event2", "event3"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    func getNbrSections (in tableView: UITableView) -> Int {
        return 1
    }

    func tableView (_ tableView: UITableView, nbrRowsInSecton section: Int) -> Int {
        return arrEvents.count
    }

    func tableView (_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "event_cell", for: indexPath)
        let net = Network()
        let records = net.getScheduleList { (errorHandle, schedules) in
            if let _ = errorHandle.errorType, let errorMessage = errorHandle.errorMessage {
                print(errorMessage)
            }
            else if let list = schedules, let schedule = list.records.last {
                print(schedule.item.activity)
                cell.textLabel!.text = list.records[indexPath.row].item.activity
            }
            else {
                print("Houston we got a problem")
            }
        }
        cell.textLabel!.text = arrEvents[indexPath.row]
        
        return cell
    }
}

