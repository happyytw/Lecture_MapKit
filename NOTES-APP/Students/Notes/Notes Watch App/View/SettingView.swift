//
//  SettingView.swift
//  Notes Watch App
//
//  Created by Taewon Yoon on 2023/09/06.
//

import SwiftUI

struct SettingView: View {
    // MARK: - PROPERTY
    
    @AppStorage("lineCount") var lineCount: Int = 1
    // @AppStorage를 사용하여 영구적으로 워치에 저장할 수 있다.
    // User Default를 사용
    // AppStorage는 userdefaults에서 lineCount key가 변경될 때 View의 body property을 자동으로 호출하고 interface에 즉시 적용시킬 수 있다.
    @State private var value: Float = 1.0
    
    // MARK: - FUNCTION
    
    func update() {
        lineCount = Int(value)
    }
    
    var body: some View {
        VStack(spacing: 8) {
            // HEADER
            HeaderView(title: "Settings")
            
            // ACTUAL LINE COUNT
            Text("Lines: \(lineCount)".uppercased())
                .fontWeight(.bold)
            // SLIDER
            Slider(value: Binding(get: { self.value }, set: { newValue in
                self.value = newValue
                self.update()
            }), in: 1...4, step: 1)
                .accentColor(.accentColor)
        } //: VSTACK
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
