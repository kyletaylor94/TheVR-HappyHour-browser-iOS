//
//  CustomDatePicker.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 07..
//

import Foundation
import SwiftUI

struct CustomDatePicker: View {
    @Binding var currentDate: Date
    var body: some View {
        DatePicker(selection: $currentDate, in: ...Date.now, displayedComponents: .date) {}
        .padding(.trailing, 60)
        .frame(width: 230, height: 50)
        .background(
            RoundedRectangle(cornerRadius: Constants.CornerRadius.four)
                .stroke(Color.chapterCell,style: StrokeStyle())
        )
    }
}
