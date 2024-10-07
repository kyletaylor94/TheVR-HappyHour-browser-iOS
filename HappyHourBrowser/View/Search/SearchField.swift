//
//  SearchField.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import SwiftUI

struct SearchField: View {
    @Binding var searchByText: String
    let placeholder: String
    
    var body: some View {
        TextField(placeholder, text: $searchByText)
            .padding()
            .frame(width: 230, height: 50)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.chapterCell,style: StrokeStyle())
            )
    }
}

#Preview {
    SearchField(searchByText: .constant(""), placeholder: "Part")
}
