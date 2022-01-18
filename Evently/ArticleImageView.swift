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
    
    var body: some View {
        if let imageURL = article.image,
           let url = URL(string: imageURL) {
            
            URLImage(url, failure: { error, _ in
                PlaceHolderImageView()
            }) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 250)
                    .clipped()
            }
            
            .environment(\.urlImageOptions, URLImageOptions(fetchPolicy: .returnStoreElseLoad(downloadDelay: 0.25), loadOptions: .loadOnAppear))
        } else {
            PlaceHolderImageView()
        }
        
        VStack(alignment: .leading) {
            Text(article.title)
                .font(.caption)
                .fontWeight(.bold)
            
            Text("\(article.date)")
                .font(.caption2)
        }
    }
}

struct ArticleImageView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleImageView(article: Article.dummyData)
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
