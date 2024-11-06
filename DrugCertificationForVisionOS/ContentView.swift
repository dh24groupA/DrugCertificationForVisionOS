//
//  ContentView.swift
//  DrugCertificationForVisionOS
//
//  Created by 植松優羽 on 2024/11/06.
//

import SwiftUI
import RealityKit
import AVFoundation

struct ContentView: View {
    @State private var isAuthenticated = true // デフォルトはfalse、テスト用にtrue
    @State private var isRecording = false
    @State private var showDatePicker = false
    @State private var recordDate = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
    @State var isShowAlert = false
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
                        setting = .drugAuth
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            
            case .drugAuth:
                VStack {
                    HStack {
                        Button(action: {
                            setting = .title
                        }) {
                            Text("戻る")
                        }
                        .padding(.leading)
                        
                        Spacer()
                        
                        Button(action: {
                            setting = .patientAuth
                        }) {
                            HStack {
                                Text("次へ")
                            }
                        }
                    }
                    .padding(.top)
                    
                    Text("ここで薬剤のコードを読み取る")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top)
                    
                    // 仮の画像表示
                    Image("medicine_bin")
                        .resizable()
                        .frame(width: 150, height: 300)
                        .padding()
                }
                .onAppear {
                    medicineName = "お薬飲めたね"
                    medicineID = "093"
                }
            
            case .patientAuth:
                VStack {
                    HStack {
                        Button(action: {
                            setting = .drugAuth
                        }) {
                            Text("戻る")
                        }
                        .padding(.leading)
                        
                        Spacer()
                        
                        Button(action: {
                            setting = .scanned
                        }) {
                            HStack {
                                Text("次へ")
                            }
                        }
                    }
                    .padding(.top)
                    
                    Text("ここで患者のコードを読み取る")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top)
                    
                    // 仮の画像表示
                    Image("keirou_couple2")
                        .resizable()
                        .frame(width: 300, height: 300)
                        .padding()
                }
                .onAppear {
                    patientName = "山田 太郎"
                    patientID = "3849872"
                }

            
            case .scanned:
                VStack {
                    HStack {
                        Button(action: {
                            setting = .patientAuth
                        }) {
                            Text("戻る")
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
                            Text("本当に？？")
                        }
                    }
                    .padding(.top)
                    
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
