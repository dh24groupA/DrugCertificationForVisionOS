//
//  Untitled.swift
//  DrugCertificationForVisionOS
//
//  Created by 植松優羽 on 2024/11/26.
//
import SwiftUI


func getMedicineData(key: String, value: String, fileName: String = "medicine") -> String {
    let medicines = loadJson(fileName: fileName)
    if let matchingMedicine = medicines.first(where: { medicine in
        let mirror = Mirror(reflecting: medicine)
        for child in mirror.children {
            if child.label == key, let childValue = child.value as? String, childValue == value {
                return true
            }
        }
        return false
    }) {
        return matchingMedicine.name
    } else {
        return "一致するデータが見つかりません"
    }
}
