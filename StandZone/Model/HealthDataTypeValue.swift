//
//  HealthDataTypeValue.swift
//  StandZone
//
//  Created by yifanlan on 3/27/22.
//

import Foundation

/// A representation of health data to use for `HealthDataTypeTableViewController`.
struct HealthDataTypeValue : Identifiable {
    var id: Int
    let startDate: Date
    let endDate: Date
    var value: Double
    
    func getDate() -> String{
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        let str1 =  formatter.string(from: startDate)
        return str1
    }
}
