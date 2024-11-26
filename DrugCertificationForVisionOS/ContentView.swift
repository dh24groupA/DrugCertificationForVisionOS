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
    
    @State private var patientName = ""
    @State private var patientID = ""
    @State private var medicineName = ""
    @State private var medicineID = ""
    
    enum Setting {
        case title
        case drugAuth
        case patientAuth
        case scanned
        case finished
    }
    
    @State private var setting = Setting.patientAuth
    
    var body: some View {
        ZStack {
            switch setting {
            case .title:
                VStack {
                    Text("薬剤認証")
                        .font(.largeTitle)
                        .padding()
                    
                    
                    Button("認証開始") {
                        setting = .drugAuth
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                
            case .drugAuth:
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
                    medicineName = "お薬飲めたね"
                    medicineID = mqrData
                    
                }
                
            case .patientAuth:
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
                                    pqrData = pqr1Data
                                    setting = .scanned
                                }) {
                                    Text("このコードを選ぶ")
                                }
                            }
                        }
                        .padding(.bottom,200)
                    }
                }
                .onAppear {
                    patientName = "山田 太郎"
                    patientID = "3849872"
                }
                
                
            case .scanned:
                ZStack{
                    VStack {
                        HStack {
                            Button(action: {
                                setting = .patientAuth
                            }) {
                                Text("戻る")
                            }
                            .padding()
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
                                Text("患者ID: \(patientID.isEmpty ? "未入力" : patientID)")
                            }
                            .padding()
                            
                            VStack(alignment: .leading, spacing: 10) {
                                Text("薬品名: \(medicineName.isEmpty ? "未入力" : medicineName)")
                                Text("投与方法: 点滴")
                                Text("投与用量: 800ml")
                            }
                        }
                        .padding()
                        
                        if showDatePicker {
                            DatePicker("記録日", selection: $recordDate, in: Date() - 1...Date(), displayedComponents: .date)
                                .datePickerStyle(WheelDatePickerStyle())
                                .labelsHidden()
                                .environment(\.locale, Locale(identifier: "ja_JP"))
                                .frame(height: 150)
                                .padding()
                        }
                    }
                }
                .onAppear {
                    medicineName = getJsonData(searchKey: "id", searchValue: mqrData, returnKey: "name", fileName: "medicines", type: medicine.self)
                    
                    patientName = getJsonData(searchKey: "id", searchValue: pqrData, returnKey: "name", fileName: "patients", type: patient.self)
                    
                    
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

#Preview(windowStyle: .automatic) {
    ContentView()
        .environment(AppModel())
}
