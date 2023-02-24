//
//  ThumbnailWrapper.swift
//  Fetch Challange
//
//  Created by Teryl S on 2/23/23.
//

import SwiftUI
import UIKit

struct ThumbnailView: View {
    var url: String?
    @State private var thumbnail: Image? = nil
    
    var body: some View {
        Group {
            if thumbnail == nil {
                ProgressView().frame(width: 50, height: 50)
            } else {
                thumbnail!.resizable().frame(width: 50, height: 50).scaledToFit()
            }
        }
        .onAppear {
            Task {
                let data = await ImageLoader.publicCache.loadAsync(url: URL(string: url!)! as NSURL)
                if let data = data {
                    await MainActor.run {
                        thumbnail = Image(uiImage: data)
                    }
                }
            }
        }
    }
        
}

struct ThumbnailWrapper_Previews: PreviewProvider {
    static var previews: some View {
        ThumbnailView()
    }
}
