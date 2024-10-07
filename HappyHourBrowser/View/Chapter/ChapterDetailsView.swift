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
                Image(systemName: Constants.shared.bookmarkIcon)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text("Chapters")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Image(systemName: chaptersTapped ? Constants.shared.chevronUpIcon : Constants.shared.chevronDownIcon)
                    .font(.caption)
                    .fontWeight(.heavy)
                    .padding(.leading, 50)
                    .padding(.top, 30)
                
                Spacer()
                
                Text("\(count)")
                    .font(.subheadline)
                    .fontWeight(.light)
            }
            .foregroundStyle(Constants.shared.chapterBlackColor)
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
                        .onTapGesture {
                            print(FormatHelper.extractTimeStamp(from: chapter))
                            print(videoId)
                            
                        }
                }
            }
        }
        .padding(.horizontal, 8)
        .frame(width: Constants.shared.rectangleWidth)
        .background(
            RoundedRectangle(cornerRadius: Constants.shared.cornerRadiusEight)
                .fill(.cellBG)
                .stroke(Color(.searchButtonBackGround))
        )
    }
}
