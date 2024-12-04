//
//  Untitled.swift
//  DrugCertificationForVisionOS
//
//  Created by 植松優羽 on 2024/11/29.
//
import SwiftUI
import Foundation

/// 日付をフォーマットして文字列として返す
/// - Parameter date: フォーマット対象の日付
/// - Returns: フォーマットされた日付の文字列。日付がない場合は「記録なし」
func formattedLastDoseDate(_ date: Date?) -> String {
    guard let date = date else { return "記録なし" }
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd HH:mm"
    return formatter.string(from: date)
}

/// 複数の投与日時を保存する
/// - Parameter dates: 保存する日付の配列
func saveDoseDates(for patientID: String, dates: [Date]) {
    let key = "doseDates_\(patientID)" // ユニークなキーを生成
    let dateData = dates.map { $0.timeIntervalSince1970 } // Dateを保存可能な形式に変換
    UserDefaults.standard.set(dateData, forKey: key)
}


/// 保存された投与日時を取得する
/// - Returns: 投与日時の配列
func loadDoseDates(for patientID: String) -> [Date] {
    let key = "doseDates_\(patientID)" // ユニークなキーを生成
    guard let dateData = UserDefaults.standard.array(forKey: key) as? [TimeInterval] else {
        return []
    }
    return dateData.map { Date(timeIntervalSince1970: $0) }
}


/// 新しい投与日時を追加し保存する
/// - Parameter date: 追加する日時
func addDoseDate(for patientID: String, date: Date) {
    var dates = loadDoseDates(for: patientID)
    dates.append(date)
    saveDoseDates(for: patientID, dates: dates)
}


/// すべての投与日時をフォーマットして文字列配列として返す
/// - Returns: フォーマットされた日時の文字列配列
func formattedAllDoseDates(for patientID: String) -> [String] {
    let dates = loadDoseDates(for: patientID) // 変更: 引数を渡す
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd HH:mm"
    return dates.map { formatter.string(from: $0) }
}

