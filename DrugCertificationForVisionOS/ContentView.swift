//
//  ContentView.swift
//  DrugCertificationForVisionOS
//
//  Created by 植松優羽 on 2024/11/06.
//

import SwiftUI
import RealityKit
import AVFoundation
import Vision

struct ContentView: View {
    @State var isShowAlert = false
    @State private var showFirstAlert = false
    @State var pqrData = ""
    @State var mqrData = ""
    
    //本来はQRコードの値を読み取って出したい奴ら
    @State var pqr1Data = "20000"
    @State var pqr2Data = "20001"
    @State var mqr1Data = "mnbvc"
    @State var mqr2Data = "lkjhg"
    @State var mqr3Data = "poiuy"
    @State var mqr4Data = "zxcvb"
    @State var mqr5Data = "qwert"
    @State var mqr6Data = "asdfg"
    
    @State private var patientID = ""
    @State private var patientName = ""
    @State private var patientAge = ""
    @State private var patientMed = ""
    @State private var patientDose = ""
    @State private var patientTime = ""
    @State private var patientNote = ""
    @State private var patientHistory = ""
    @State private var patientAllergy = ""
    @State private var patientPhoto = ""
    @State private var patientCurrentIllness = ""
    
    @State private var medID = ""
    @State private var medName = ""
    @State private var medPurpose = ""
    @State private var medRoute = ""
    @State private var medFrequency = ""
    @State private var medSideEffects = ""
    @State private var medContraindications = ""
    
    //@State private var lastDoseDate: Date? = nil//前回の記録日時
    @State private var currentTime = Date() // 現在時刻を保持
    @State private var pastDates: [Date] = []
    
    
    enum Setting {
        case title
        case medAuth
        case patientAuth
        case scanned
        case finished
    }
    
    @State private var setting = Setting.title
    
    var body: some View {
        ZStack {
            switch setting {
            case .title:
                VStack {
                    Text("薬剤認証")
                        .font(.largeTitle)
                        .padding()
                    
                    
                    Button("認証開始") {
                        setting = .medAuth
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .onAppear {
                    
                }
                
            case .medAuth:
                ZStack{
                    VStack {
                        HStack {
                            Button(action: {
                                setting = .title
                            }) {
                                Text("戻る")
                            }
                            .padding(.leading)
                            Spacer()
                            
                            Text("薬剤選択画面")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .top)
                                .padding(.trailing,100)//微調整
                            
                        }
                        .padding()
                        Spacer()
                        
                        VStack{
                            HStack{
                                VStack{
                                    UIKitImageView(imageName: "MQR1")
                                        .frame(width: 75, height: 75)
                                        .padding(80)
                                    
                                    Button(action: {
                                        mqrData = mqr1Data
                                        setting = .patientAuth
                                    }) {
                                        Text("このコードを選ぶ")
                                    }
                                }
                                .padding(.trailing,100)
                                
                                VStack{
                                    UIKitImageView(imageName: "MQR2")
                                        .frame(width: 75, height: 75)
                                        .padding(80)
                                    
                                    Button(action: {
                                        mqrData = mqr2Data
                                        setting = .patientAuth
                                    }) {
                                        Text("このコードを選ぶ")
                                    }
                                }
                                .padding(.trailing,100)
                                
                                VStack{
                                    UIKitImageView(imageName: "MQR3")
                                        .frame(width: 75, height: 75)
                                        .padding(80)
                                    
                                    Button(action: {
                                        mqrData = mqr3Data
                                        setting = .patientAuth
                                    }) {
                                        Text("このコードを選ぶ")
                                    }
                                }
                            }
                            
                            HStack{
                                VStack{
                                    UIKitImageView(imageName: "MQR4")
                                        .frame(width: 75, height: 75)
                                        .padding(80)
                                    
                                    Button(action: {
                                        mqrData = mqr4Data
                                        setting = .patientAuth
                                    }) {
                                        Text("このコードを選ぶ")
                                    }
                                }
                                .padding(.trailing,100)
                                
                                VStack{
                                    UIKitImageView(imageName: "MQR5")
                                        .frame(width: 75, height: 75)
                                        .padding(80)
                                    
                                    Button(action: {
                                        mqrData = mqr5Data
                                        setting = .patientAuth
                                    }) {
                                        Text("このコードを選ぶ")
                                    }
                                }
                                .padding(.trailing,100)
                                
                                VStack{
                                    UIKitImageView(imageName: "MQR6")
                                        .frame(width: 75, height: 75)
                                        .padding(80)
                                    
                                    Button(action: {
                                        mqrData = mqr6Data
                                        setting = .patientAuth
                                    }) {
                                        Text("このコードを選ぶ")
                                    }
                                }
                            }
                            .padding(.bottom)
                        }
                    }
                }
                .onAppear {
                    
                    
                }
                .onDisappear{
                    medName = getJsonData(searchKey: "id", searchValue: mqrData, returnKey: "name", fileName: "medicines", type: medicine.self)
                    
                    medPurpose = getJsonData(searchKey: "id", searchValue: mqrData, returnKey: "purpose", fileName: "medicines", type: medicine.self)
                    
                    medRoute = getJsonData(searchKey: "id", searchValue: mqrData, returnKey: "route", fileName: "medicines", type: medicine.self)
                    
                    medFrequency = getJsonData(searchKey: "id", searchValue: mqrData, returnKey: "frequency", fileName: "medicines", type: medicine.self)
                    
                    medSideEffects = getJsonData(searchKey: "id", searchValue: mqrData, returnKey: "sideEffects", fileName: "medicines", type: medicine.self)
                    
                    medContraindications = getJsonData(searchKey: "id", searchValue: mqrData, returnKey: "contraindications", fileName: "medicines", type: medicine.self)
                    
                }
                
            case .patientAuth:
                ZStack{
                    VStack {
                        HStack {
                            Button(action: {
                                setting = .medAuth
                            }) {
                                Text("戻る")
                            }
                            .padding(.leading)
                            Spacer()
                            
                            Text("患者選択画面")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .top)
                                .padding(.trailing,100)//微調整
                            
                        }
                        .padding()
                        Spacer()
                        
                        HStack{
                            VStack{
                                UIKitImageView(imageName: "PQR1")
                                    .frame(width: 75, height: 75)
                                    .padding(80)
                                
                                Button(action: {
                                    pqrData = pqr1Data
                                    setting = .scanned
                                }) {
                                    Text("このコードを選ぶ")
                                }
                            }
                            .padding(.trailing,200)
                            
                            VStack{
                                UIKitImageView(imageName: "PQR2")
                                    .frame(width: 75, height: 75)
                                    .padding(80)
                                
                                Button(action: {
                                    pqrData = pqr2Data
                                    setting = .scanned
                                }) {
                                    Text("このコードを選ぶ")
                                }
                            }
                        }
                        .padding(.bottom,200)
                    }
                }
                .onDisappear {
                    
                    patientName
                    = getJsonData(searchKey: "id", searchValue: pqrData, returnKey: "name", fileName: "patients", type: patient.self)
                    
                    patientAge = getJsonData(searchKey: "id", searchValue: pqrData, returnKey: "age", fileName: "patients", type: patient.self)
                    
                    patientMed = getJsonData(searchKey: "id", searchValue: pqrData, returnKey: "medicine", fileName: "patients", type: patient.self)
                    
                    patientDose = getJsonData(searchKey: "id", searchValue: pqrData, returnKey: "dose", fileName: "patients", type: patient.self)
                    
                    patientTime = getJsonData(searchKey: "id", searchValue: pqrData, returnKey: "time", fileName: "patients", type: patient.self)
                    
                    patientNote = getJsonData(searchKey: "id", searchValue: pqrData, returnKey: "note", fileName: "patients", type: patient.self)
                    
                    patientHistory = getJsonData(searchKey: "id", searchValue: pqrData, returnKey: "history", fileName: "patients", type: patient.self)
                    
                    patientAllergy = getJsonData(searchKey: "id", searchValue: pqrData, returnKey: "allergy", fileName: "patients", type: patient.self)
                    
                    patientPhoto = getJsonData(searchKey: "id", searchValue: pqrData, returnKey: "photo", fileName: "patients", type: patient.self)
                    
                    patientCurrentIllness = getJsonData(searchKey: "id", searchValue: pqrData, returnKey: "currentIllness", fileName: "patients", type: patient.self)
                    
                    patientID = pqrData
                    
                    let formattedDates = formattedAllDoseDates(for: patientID)
                    formattedDates.forEach { print($0) }
                }
                
            case .scanned:
                ZStack {
                    VStack(alignment: .leading, spacing: 14) {
                        HStack {
                            
                            Spacer()
                            
                            Text("薬剤投与前最終確認")
                                .font(.largeTitle)
                                .bold()
                                .padding(.horizontal)
                            
                            Spacer()
                            
                            if cmpstr(str1: medName, str2: patientMed) {
                                Button(role: .destructive) {
                                    isShowAlert = true
                                } label: {
                                    Label("完了", systemImage: "pencil.and.outline")
                                }
                                .alert("本当に完了しますか？", isPresented: $isShowAlert) {
                                    Button("No") {}
                                    Button("Yes") {
                                        setting = .finished
                                        let now = Date()
                                        addDoseDate(for: patientID, date: now)

                                    }
                                } message: {
                                    Text("完了すると看護記録に投与履歴が送信されます")
                                }
                            } else {
                                Button(role: .destructive) {
                                    showFirstAlert = true
                                } label: {
                                    Label("薬剤不一致", systemImage: "pencil.and.outline")
                                }
                                .alert("投与予定の薬剤と選択された薬剤が一致しません", isPresented: $showFirstAlert) {
                                    Button("戻る") {}
                                    Button("QRコードを再読み込み") {
                                        setting = .medAuth
                                    }
                                }
                            }
                        }
                        .padding()
                        
                        Divider()
                        
                        HStack(alignment: .top) {
                            VStack(alignment: .leading, spacing: 16) {
                                Section(header: Text("患者情報")
                                    .font(.headline)
                                    .foregroundColor(.gray)) {
                                        UIKitImageView(imageName: patientPhoto)
                                            .frame(width: 100, height: 100)
                                            .padding([.bottom,.leading], 120)
                                            .padding(.top,100)
                                        
                                        HStack {
                                            Text("患者名:")
                                                .fontWeight(.bold)
                                                .foregroundColor(.secondary)
                                            Text("\(patientName.isEmpty ? "未入力" : patientName)")
                                        }
                                        
                                        HStack {
                                            Text("年齢:")
                                                .fontWeight(.bold)
                                                .foregroundColor(.secondary)
                                            Text("\(patientAge.isEmpty ? "未入力" : patientAge)")
                                        }
                                        
                                        HStack {
                                            Text("病名:")
                                                .fontWeight(.bold)
                                                .foregroundColor(.secondary)
                                            Text("\(patientCurrentIllness.isEmpty ? "未入力" : patientCurrentIllness)")
                                        }
                                        
                                        HStack {
                                            Text("既往歴:")
                                                .fontWeight(.bold)
                                                .foregroundColor(.secondary)
                                            Text("\(patientHistory.isEmpty ? "未入力" : patientHistory)")
                                        }
                                        
                                        HStack {
                                            Text("アレルギー情報:")
                                                .fontWeight(.bold)
                                                .foregroundColor(.secondary)
                                            Text("\(patientAllergy.isEmpty ? "未入力" : patientAllergy)")
                                        }
                                        
                                        HStack {
                                            Text("注意事項:")
                                                .fontWeight(.bold)
                                                .foregroundColor(.secondary)
                                            Text("\(patientNote.isEmpty ? "未入力" : patientNote)")
                                        }
                                    }
                            }
                            Divider()
                            VStack(alignment: .leading, spacing: 16) {
                                Section(header: Text("記録情報")
                                    .font(.headline)
                                    .foregroundColor(.gray)) {
                                        HStack {
                                            Text("記録日時:")
                                                .fontWeight(.bold)
                                                .foregroundColor(.secondary)
                                            Text("\(formattedDate(currentTime))")
                                        }
                                        HStack {
                                            Text("過去3回の記録日時:")
                                                .fontWeight(.bold)
                                                .foregroundColor(.secondary)
                                            VStack(alignment: .leading, spacing: 10) {
                                                ForEach(pastDates.suffix(3), id: \.self) { date in
                                                    Text(formattedLastDoseDate(date))
                                                        .padding(.bottom, 5) // 各テキストの間に少し余白を追加
                                                }
                                            }

                                        }
                                    }
                                
                                Divider()
                                
                                Section(header: Text("投与薬剤")
                                    .font(.headline)
                                    .foregroundColor(.gray)) {
                                        
                                        if(cmpstr(str1: medName, str2: patientMed)){
                                            VStack(alignment: .leading, spacing: 16){
                                                HStack {
                                                    Text("薬剤名:")
                                                        .fontWeight(.bold)
                                                        .foregroundColor(.secondary)
                                                    Text("\(medName.isEmpty ? "未入力" : medName)")
                                                }
                                                    HStack {
                                                        Text("用途:")
                                                            .fontWeight(.bold)
                                                            .foregroundColor(.secondary)
                                                        Text("\(medPurpose.isEmpty ? "未入力" : medPurpose)")
                                                    }
                                                    HStack {
                                                        Text("副作用:")
                                                            .fontWeight(.bold)
                                                            .foregroundColor(.secondary)
                                                        Text("\(medSideEffects.isEmpty ? "未入力" : medSideEffects)")
                                                    }
                                                    HStack {
                                                        Text("投与方法:")
                                                            .fontWeight(.bold)
                                                            .foregroundColor(.secondary)
                                                        Text("\(medRoute.isEmpty ? "未入力" : medRoute)")
                                                    }
                                                    HStack {
                                                        Text("投与頻度:")
                                                            .fontWeight(.bold)
                                                            .foregroundColor(.secondary)
                                                        Text("\(medFrequency.isEmpty ? "未入力" : medFrequency)")
                                                    }
                                                    HStack {
                                                        Text("禁忌:")
                                                            .fontWeight(.bold)
                                                            .foregroundColor(.red)
                                                        Text("\(medContraindications.isEmpty ? "未入力" : medContraindications)")
                                                    }
                                                }
                                        }else{
                                            VStack(alignment: .leading, spacing: 16){
                                                HStack {
                                                    Text("処方薬剤:")
                                                        .fontWeight(.bold)
                                                        .foregroundColor(.secondary)
                                                    Text("\(medName.isEmpty ? "未入力" : medName)")
                                                        .foregroundColor(.red)
                                                    
                                                }
                                                HStack {
                                                    Text("読み込んだ薬剤:")
                                                        .fontWeight(.bold)
                                                        .foregroundColor(.secondary)
                                                    Text("\(patientMed.isEmpty ? "未入力" : patientMed)")
                                                        .foregroundColor(.red)
                                                }
                                            }
                                        }
                                        
                                    }
                            }
                        }
                        .padding()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top) // 全体を上寄せ
                    .background(Color(.systemGroupedBackground))
                    .cornerRadius(10)
                    .shadow(radius: 5)
                }
                
                .onAppear{
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                        currentTime = Date()
                    }
                    pastDates = loadDoseDates(for: pqrData)
                }
                
            case .finished:
                VStack {
                    Text("投与を記録しました")
                        .padding()
                    
                    Button(action: {
                        setting = .title
                        
                    }) {
                        Text("最初から記録する")
                    }
                }
            }
        }
    }
}



func formattedDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd HH:mm"
    return formatter.string(from: date)
}

func cmpstr(str1: String,str2: String) -> Bool{
    if(str1 == str2){
        return true
    }else{
        return false
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
        .environment(AppModel())
}
