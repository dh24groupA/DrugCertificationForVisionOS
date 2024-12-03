//
//  loadJson.swift
//  DrugCertificationForVisionOS
//
//  Created by 植松優羽 on 2024/11/26.
//
import SwiftUI

struct medicine: Codable {
    var id: String          //薬品id
    var name: String        //薬品名
    var purpose: String     //投与目的
    var route: String       //投与方法
    var frequency: String //投与頻度
    var sideEffects: String//副作用
    var contraindications: String//禁忌事項
}

struct patient: Codable {
    var id: String          //患者ID
    var name: String        //患者氏名
    var age: String         //年齢
    var medicine: String    //投与薬剤名
    var dose: String        //用量
    var time: String        //投与時間
    var note: String        //注意事項
    var history: String     //既往歴
    var allergy: String     //アレルゲン
    var photo: String       //写真名
}

func loadJson<T: Codable>(fileName: String, type: T.Type) -> [T] {
    guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
        print("Error: \(fileName).json ファイルが見つかりません")
        return []
    }
    do {
        let data = try Data(contentsOf: url)
        let fileData = try JSONDecoder().decode([T].self, from: data)
        return fileData
    } catch {
        print("Error: \(error)")
        return []
    }
}
