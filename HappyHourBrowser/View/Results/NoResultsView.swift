//
//  NoResultsView.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import SwiftUI

struct NoResultsView: View {
    var body: some View {
        VStack{
            RoundedRectangle(cornerRadius: 12)
                .frame(width: 100, height: 100)
                .foregroundStyle(.cellBG)
                .overlay {
                    VStack{
                        Image(systemName: "exclamationmark.magnifyingglass")
                            .font(.title2)
                            .foregroundStyle(.chapterCell)
                        Text("No result!")
                    }
                }
        }
    }
}

#Preview {
    NoResultsView()
}
