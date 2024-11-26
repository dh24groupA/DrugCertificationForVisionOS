//
//  Untitled.swift
//  DrugCertificationForVisionOS
//
//  Created by 植松優羽 on 2024/11/26.
//
import SwiftUI


func getJsonData<T: Codable>(
    searchKey: String,
    searchValue: String,
    returnKey: String,
    fileName: String = "medicine",
    type: T.Type
) -> String {
    // 修正した loadJson を使用
    let items = loadJson(fileName: fileName, type: type)
    
    // 検索対象のデータを見つける
    if let matchingItem = items.first(where: { item in
        let mirror = Mirror(reflecting: item)
        for child in mirror.children {
            if child.label == searchKey, let childValue = child.value as? String, childValue == searchValue {
                return true
            }
        }
        return false
    }) {
        // 指定したキーの値を返す
        let mirror = Mirror(reflecting: matchingItem)
        for child in mirror.children {
            if child.label == returnKey, let returnValue = child.value as? String {
                return returnValue
            }
        }
    }
    return "一致するデータが見つかりません"
}
