//
//  main.swift
//  Test
//
//  Created by user186364 on 07/04/2021.
//

import Foundation
import ModelIO
import Network

var net = Network()

net.getScheduleList { (errorHandle, schedules) in
    if let _ = errorHandle.errorType, let errorMessage = errorHandle.errorMessage {
        print(errorMessage)
    }
    else if let list = schedules, let schedule = list.records.last {
        print(schedule.item.activity)
    }
    else {
        print("Houston we got a problem")
    }
}
