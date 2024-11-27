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
    @State private var showDatePicker = false
    @State private var recordDate = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
    @State var isShowAlert = false
    @State private var showFirstAlert = false
    @State private var showSecondAlert = false
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
    
    @State private var medID = ""
    @State private var medName = ""
    @State private var medPurpose = ""
    @State private var medRoute = ""
    
    
    enum Setting {
        case title
        case medAuth
        case patientAuth
        case scanned
        case scannedExact
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
                                        .frame(width: 75, height: 75) // 表示サイズを指定
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
                                        .frame(width: 75, height: 75) // 表示サイズを指定
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
                                        .frame(width: 75, height: 75) // 表示サイズを指定
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
                                        .frame(width: 75, height: 75) // 表示サイズを指定
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
                                        .frame(width: 75, height: 75) // 表示サイズを指定
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
                                        .frame(width: 75, height: 75) // 表示サイズを指定
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
                                    .frame(width: 75, height: 75) // 表示サイズを指定
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
                                    .frame(width: 75, height: 75) // 表示サイズを指定
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
                    
    
                }
                
                

                // scanned状態でのアラート表示部分を以下のように修正

                case .scanned:
                    ZStack {
                        VStack {
                            HStack {
                                Button(action: {
                                    setting = .patientAuth
                                }) {
                                    Text("scanned")
                                }
                                .padding(.leading)
                                Spacer()
                                
                                Text("薬剤投与前最終確認")
                                    .font(.largeTitle)
                                    .bold()
                                    .padding(.bottom)
                                    .padding(.horizontal)
                                
                                Spacer()
                                
                                Button(role: .destructive) {
                                    showFirstAlert = true  // 最初のアラートを表示
                                } label: {
                                    Label("投与予定の薬剤と選択された薬剤が一致しません", systemImage: "pencil.and.outline")
                                }
                                .alert("投与予定の薬剤と選択された薬剤が一致しません", isPresented: $showFirstAlert) {
                                    Button("No") {}
                                    Button("Yes") {
                                        // 最初のアラートが閉じられた後、次のアラートを表示
                                        showSecondAlert = true
                                    }
                                } message: {
                                    Text("それでも投与記録を残しますか？")
                                }
                            }
                            .padding()
                            Spacer()
                            
                            HStack {
                                VStack(alignment: .leading, spacing: 10) {
                                    HStack {
                                        Text("記録日:")
                                        Text("\(formattedDate(recordDate))")
                                            .onTapGesture {
                                                withAnimation {
                                                    showDatePicker.toggle()
                                                }
                                            }
                                    }
                                    Text("患者名: \(patientName.isEmpty ? "未入力" : patientName)")
                                    Text("年齢: \(patientAge.isEmpty ? "未入力" : patientAge)")
                                }
                                .padding()
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("投与すべき薬剤: \(patientMed.isEmpty ? "未入力" : patientMed)")
                                    Text("投与する薬剤: \(medName.isEmpty ? "未入力" : medName)")
                                    Text("投与方法: \(medRoute.isEmpty ? "未入力" : medRoute)")
                                    Text("注意事項: \(patientNote.isEmpty ? "未入力" : patientNote)")
                                }
                            }
                            .padding(.bottom, 0)
                            .frame(maxWidth: .infinity, maxHeight: .infinity) // 親ビューを画面全体に
                        }
                        .alert("本当に記録しますか？", isPresented: $showSecondAlert) { // 2番目のアラート
                            Button("No") {}
                            Button("Yes", action: {
                                setting = .finished
                            })
                        } message: {
                            Text("投与記録を完了しました。")
                        }
                    }
                    .onAppear{
                        if cmpstr(str1: medName, str2: patientMed){
                            setting = .scannedExact
                        }else{
                            setting = .scanned
                        }
                    }
                
            case .scannedExact:
                ZStack{
                    VStack {
                        HStack {
                            Button(action: {
                                setting = .patientAuth
                            }) {
                                Text("Exact")
                            }
                            .padding(.leading)
                            Spacer()
                            
                            Text("薬剤投与前最終確認")
                                .font(.largeTitle)
                                .bold()
                                .padding(.bottom)
                                .padding(.horizontal)
                            
                            Spacer()
                            
                            Button(role: .destructive) {
                                isShowAlert = true
                            } label: {
                                Label("投与完了する", systemImage: "pencil.and.outline")
                            }
                            .alert("本当に完了しますか？", isPresented: $isShowAlert) {
                                Button("No") {}
                                Button("Yes") {
                                    setting = .finished
                                }
                            } message: {
                                Text("完了すると看護記録に投与履歴が送信されます")
                            }
                        }
                        .padding()
                        Spacer()
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
                                    Text("記録日:")
                                    Text("\(formattedDate(recordDate))")
                                        .onTapGesture {
                                            withAnimation {
                                                showDatePicker.toggle()
                                            }
                                        }
                                }
                                Text("患者名: \(patientName.isEmpty ? "未入力" : patientName)")
                                Text("年齢: \(patientAge.isEmpty ? "未入力" : patientAge)")
                            }
                            .padding()
                            
                            VStack(alignment: .leading, spacing: 10) {
                                Text("投与する薬剤: \(patientMed.isEmpty ? "未入力" : patientMed)")
                                Text("投与方法: \(medRoute.isEmpty ? "未入力" : medRoute)")
                                Text("注意事項: \(patientNote.isEmpty ? "未入力" : patientNote)")
                            }
                        }
                        .padding(.bottom, 0)
                        .frame(maxWidth: .infinity, maxHeight: .infinity) // 親ビューを画面全体に
                        
                    }
                }
                .onAppear {
                    if cmpstr(str1: medName, str2: patientMed){
                        setting = .scannedExact
                    }else{
                        setting = .scanned
                    }
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
    formatter.dateFormat = "yy/MM/dd"
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
