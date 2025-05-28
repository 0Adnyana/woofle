//
//  Helper.swift
//  Woofle_App_CH2
//
//  Created by Rahel on 20/05/25.
//

// Getting the hex colors work


import SwiftUI
import Foundation


//Extension of Color Initialization from HEX
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: Double
        r = Double((int >> 16) & 0xFF) / 255
        g = Double((int >> 8) & 0xFF) / 255
        b = Double(int & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
}


// Function to get Years from Month eg. 7 Years 5 Month
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
