//
//  StandZoneSupport.swift
//  StandZone
//
//  Created by yifanlan on 4/23/22.
//

import Foundation

func compareDate(date1: Date, date2: Date) -> Bool{
    //
    let calendar = Calendar.current

    let hour1 = calendar.component(.hour, from: date1)
    let minutes1 = calendar.component(.minute, from: date1)
    let seconds1 = calendar.component(.second, from: date1)
    
    let hour2 = calendar.component(.hour, from: date2)
    let minutes2 = calendar.component(.minute, from: date2)
    let seconds2 = calendar.component(.second, from: date2)
    
    if hour1 > hour2 {
        return true
    }
    
    if hour1 > hour2 {
        return false
    }
    
    if minutes1 > minutes2 {
        return true
    }
    
    if minutes1 < minutes2 {
        return false
    }
    
    if seconds1 > seconds2 {
        return true
    }
    
    else {
        return false
    }
    
}
