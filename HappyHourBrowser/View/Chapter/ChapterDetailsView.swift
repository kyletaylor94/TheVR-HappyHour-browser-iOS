//
//  ChapterDetailsView.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import SwiftUI

struct ChapterDetailsView: View {
    @Binding var chaptersTapped: Bool
    let count: Int
    let formattedTimeStamp: [String]
    let videoId: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Image(systemName: "bookmark.fill")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.black.opacity(0.7))
                
                Text("Chapters")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.black.opacity(0.7))
                
                Image(systemName: chaptersTapped ? "chevron.up" : "chevron.down")
                    .font(.caption)
                    .fontWeight(.heavy)
                    .foregroundColor(.black.opacity(0.7))
                    .padding(.leading, 50)
                    .padding(.top, 30)
                
                Spacer()
                
                Text("\(count)")
                    .font(.subheadline)
                    .fontWeight(.light)
            }
            .frame(height: 70)
            .onTapGesture {
                withAnimation {
                    chaptersTapped.toggle()
                }
            }
            
            if chaptersTapped {
                ForEach(formattedTimeStamp, id: \.self) { chapter in
                    ChapterCell(chapter: chapter, timeStampString: FormatHelper.extractTimeStamp(from: chapter), videoId: videoId)
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .padding(.bottom, chapter == formattedTimeStamp.last ? 5 : 0)
                }
            }
        }
        .padding(.horizontal, 8)
        .frame(width: UIScreen.main.bounds.width - 32)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(.cellBG)
                .stroke(Color(.searchButtonBackGround))
        )
    }
}
