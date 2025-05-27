//
//  FunctionHelpers.swift
//  Woofle
//
//  Created by IP Marry Kusuma on 23/05/25.
//

import Foundation

func getYearsfromMonth(for month: Int) -> String {
    var strYearMonth: String
    
    if (month / 12) > 0 {
        strYearMonth = "\(abs(month / 12)) Years"
        
        if month % 12 > 0 {
            strYearMonth += " \(month % 12) Month"
        }
        
        return strYearMonth
    }
    else {
        return "\(month) Month"
    }
}
