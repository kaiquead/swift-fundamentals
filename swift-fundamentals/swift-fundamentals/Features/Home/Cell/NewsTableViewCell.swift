//
//  NewsTableViewCell.swift
//  swift-fundamentals
//
//  Created by Kaique Alves on 08/07/25.
//

import Foundation
import UIKit
import SnapKit

class NewsTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "NewsTableViewCell"
    
    // MARK: - Lazy properties
    
    lazy var newsImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        imageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        return imageView
    }()
    
    lazy var textStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Lorem Ipsum Dolor"
        titleLabel.numberOfLines = 2
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = Colors.homeRed
        titleLabel.textAlignment = .left
        return titleLabel
    }()
    
    lazy var descriptionLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Lorem Ipsum Dolor Siamet"
        titleLabel.font = .systemFont(ofSize: 12, weight: .regular)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
        return titleLabel
    }()
    
    lazy var dateLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "12/12/12"
        titleLabel.font = .systemFont(ofSize: 12, weight: .regular)
        titleLabel.textColor = .gray
        titleLabel.textAlignment = .left
        return titleLabel
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Preparation
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsImageView.image = nil
        titleLabel.text = nil
        descriptionLabel.text = nil
    }
    
    func prepare(with article: HomeNews.Article) {
        titleLabel.text = article.title
        descriptionLabel.text = article.description
        dateLabel.text = FormatDate.format(dateString: article.publishedAt)
        guard let urlToImage = article.urlToImage else { return }
        loadImage(from: urlToImage, in: newsImageView)
    }
    
    // MARK: - Configure
    
    private func configure() {
        configurNewsImageView()
        configureTextStackView()
        configureTitleLabel()
        configureDescriptionLabel()
        configureDateLabel()
    }
    
    private func configurNewsImageView() {
        addSubview(newsImageView)
        newsImageView.snp.makeConstraints { make in
            make.height.equalTo(150)
            make.width.equalTo(160)
            make.top.leading.bottom.equalToSuperview()
        }
    }
    
    private func configureTextStackView() {
        addSubview(textStackView)
        textStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(16)
            make.leading.equalTo(newsImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(8)
        }
    }
    
    private func configureTitleLabel() {
        textStackView.addArrangedSubview(titleLabel)
    }
    
    private func configureDescriptionLabel() {
        textStackView.addArrangedSubview(descriptionLabel)
    }
    
    private func configureDateLabel() {
        textStackView.addArrangedSubview(dateLabel)
    }
}

// MARK: - Load async image

extension NewsTableViewCell {
    
    func loadImage(from url: URL, in imageView: UIImageView) {
        
        // MARK: - Check in cache
        
        if let cachedImage = ImageCache.shared.image(for: url) {
            imageView.image = cachedImage
            return
        }
        
        // MARK: - Load image

        DispatchQueue.global(qos: .background).async {
            guard let data = try? Data(contentsOf: url), let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    imageView.image = nil
                }
                return
            }

            ImageCache.shared.setImage(image, for: url)

            DispatchQueue.main.async {
                imageView.image = image
            }
        }
    }
}
