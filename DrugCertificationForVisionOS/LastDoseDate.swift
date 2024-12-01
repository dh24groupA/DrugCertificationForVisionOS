//
//  Untitled.swift
//  DrugCertificationForVisionOS
//
//  Created by 植松優羽 on 2024/11/29.
//
import SwiftUI

func formattedLastDoseDate(_ date: Date?) -> String {
    guard let date = date else { return "記録なし" }
    let formatter = DateFormatter()
    formatter.dateFormat = "yy/MM/dd HH:mm"
    return formatter.string(from: date)
}


func saveLastDoseDate(_ date: Date) {
    UserDefaults.standard.set(date, forKey: "lastDoseDate")
}

func loadLastDoseDate() -> Date? {
    return UserDefaults.standard.object(forKey: "lastDoseDate") as? Date
}
