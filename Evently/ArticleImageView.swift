//
//  ArticleImageView.swift
//  Evently
//
//  Created by Cleo Howard on 1/17/22.
//

import SwiftUI
import URLImage

struct ArticleImageView: View {
    
    let article: Article
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        if let imageURL = article.image,
            let url = URL(string: imageURL) {
            
            URLImage(url, failure: { error, _ in
                PlaceHolderImageView()
            }) { image in
                image
                    .resizable()
                    .frame(width: width, height: height)
                    .clipped()
            }
            
            .environment(\.urlImageOptions, URLImageOptions(fetchPolicy: .returnStoreElseLoad(downloadDelay: 0.25), loadOptions: .loadOnAppear))
        } else {
           PlaceHolderImageView()
        }
    }
}

struct ArticleImageView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleImageView(article: Article.dummyData,
                         width: 250,
                         height: 250)
    }
}

struct PlaceHolderImageView: View {
    var body: some View {
        Image(systemName: "photo.fill")
            .foregroundColor(.white)
            .background(.gray)
            .frame(width: 250, height: 200)
    }
}
