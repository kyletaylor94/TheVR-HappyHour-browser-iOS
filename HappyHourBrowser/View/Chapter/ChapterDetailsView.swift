//
//  ChapterDetailsView.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import SwiftUI
import Shimmer

struct ChapterDetailsView: View {
    @Binding var chaptersTapped: Bool
    @Binding var isLoading: Bool
    
    let count: Int
    let formattedTimeStamp: [String]
    let videoId: String

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Image(systemName: Constants.Icons.bookmark)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text("Chapters")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Image(systemName: chaptersTapped ? Constants.Icons.chevronUp : Constants.Icons.chevronDown)
                    .font(.caption)
                    .fontWeight(.heavy)
                    .padding(.leading, 50)
                    .padding(.top, 30)
                
                Spacer()
                
                Text("\(count)")
                    .font(.subheadline)
                    .fontWeight(.light)
            }
            .redacted(reason: isLoading ?  .placeholder : .invalidated)
            .shimmering(active: isLoading ? true : false)
            .foregroundStyle(Constants.chapterBlackColor)
            .frame(height: 70)
            .onTapGesture {
                withAnimation {
                    chaptersTapped.toggle()
                }
            }
            
            if chaptersTapped {
                ForEach(formattedTimeStamp, id: \.self) { chapter in
                    ChapterCell(chapter: chapter, timeStampString: FormatHelper.extractTimeStamp(from: chapter), videoId: videoId, isLoading: $isLoading)
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .padding(.bottom, chapter == formattedTimeStamp.last ? 5 : 0)
                }
            }
        }
        .padding(.horizontal, 8)
        .frame(width: Constants.rectangleWidth)
        .background(
            RoundedRectangle(cornerRadius: Constants.CornerRadius.eight)
                .fill(.cellBG)
                .stroke(Color(.searchButtonBackGround))
        )
    }
}
