//
//  ArticleDetailView.swift
//  swift-fundamentals
//
//  Created by Kaique Alves on 09/07/25.
//

import SwiftUI

struct ArticleDetailView: View {
    let articleDetailModel: ArticleDetailModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Image(uiImage: articleDetailModel.image ?? UIImage())
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 250)
                    .cornerRadius(10)

                Text(articleDetailModel.title ?? "")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.white)

                Text(articleDetailModel.description ?? "")
                    .font(.body)
                    .foregroundColor(Color.white)

                Text(articleDetailModel.date ?? "")
                    .font(.footnote)
                    .foregroundColor(Color.white)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(Color(red: 28/255, green: 42/255, blue: 60/255))
    }
}

struct ArticleDetailModel {
    let title: String?
    let description: String?
    let date: String?
    let image: UIImage?
}

#Preview {
    ArticleDetailView(articleDetailModel: .init(title: "Emprego novo para os mais velhos", description: "Governo do estado de São Paulo busca pessoas com 60 anos e mais para ocupar um cargo de diretor de uma empresa", date: "12/12/12", image: .add))
}
