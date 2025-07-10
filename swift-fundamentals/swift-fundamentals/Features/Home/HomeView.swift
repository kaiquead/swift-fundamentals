//
//  HomeView.swift
//  swift-fundamentals
//
//  Created by Kaique Alves on 07/07/25.
//

import Foundation
import UIKit
import SnapKit

protocol HomeViewDelegate: AnyObject {
    func loadMoreNewsFromInfinityScroll()
    func selectedArticle(article: HomeNews.Article)
}

class HomeView: UIView {
    
    // MARK: - Lazy properties
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = StringLocalizer.homeTitle
        titleLabel.font = .systemFont(ofSize: 32, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        return titleLabel
    }()
    
    lazy var searchButton: UIButton = {
        let searchButton = UIButton()
        searchButton.setTitle(StringLocalizer.searchTitle, for: .normal)
        searchButton.backgroundColor = Colors.homeRed
        searchButton.layer.cornerRadius = 12
        searchButton.layer.masksToBounds = true
        searchButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        return searchButton
    }()
    
    lazy var searchTextField: UITextField = {
        let searchTextField = UITextField()
        searchTextField.placeholder = StringLocalizer.searchTitle
        searchTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        searchTextField.leftViewMode = .always
        searchTextField.backgroundColor = .white
        searchTextField.layer.cornerRadius = 12
        searchTextField.layer.masksToBounds = true
        searchTextField.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        return searchTextField
    }()
    
    lazy var newsTableView: UITableView = {
        let newsTableView = UITableView()
        newsTableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.reuseIdentifier)
        newsTableView.dataSource = self
        newsTableView.delegate = self
        return newsTableView
    }()
    
    
    lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.startAnimating()
        return spinner
    }()
    
    // MARK: - Delegate
    
    weak var delegate: HomeViewDelegate?
    
    // MARK: - Private properties
    
    private var articles: [HomeNews.Article] = []
    private var isLoading = false
    private var totalArticles = 0
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configure()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func dismissKeyboard() {
        endEditing(true)
    }
    
    // MARK: - Configuration
    
    private func configure() {
        backgroundColor = Colors.homeBackground
        
        configureTitleLabel()
        configureSearchButton()
        configureSearchTextField()
        configureNewsTableView()
    }
    
    private func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(24)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func configureSearchButton() {
        addSubview(searchButton)
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.trailing.equalToSuperview().inset(16)
            make.width.equalTo(100)
            make.height.equalTo(44)
        }
    }
    
    private func configureSearchTextField() {
        addSubview(searchTextField)
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalTo(searchButton.snp.leading)
            make.height.equalTo(44)
        }
    }
    
    private func configureNewsTableView() {
        addSubview(newsTableView)
        newsTableView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    // MARK: - Public methods
    
    func loadArticles(articles: [HomeNews.Article], totalArticles: Int) {
        setIsLoading(false)
        self.articles += articles
        self.totalArticles = totalArticles
        
        DispatchQueue.main.async {
            self.newsTableView.reloadData()
        }
    }
    
    func setIsLoading(_ loading: Bool) {
        isLoading = loading
        
        if !isLoading {
            newsTableView.tableFooterView = nil
        }
    }
}

// MARK: - TableView

extension HomeView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reuseIdentifier, for: indexPath) as? NewsTableViewCell
        else {
            return UITableViewCell()
        }
        
        let article = articles[indexPath.row]
        cell.prepare(with: article)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = articles[indexPath.row]
        delegate?.selectedArticle(article: selected)
    }
}

extension HomeView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == articles.count - 2, !isLoading, articles.count != totalArticles {
            setIsLoading(true)
            newsTableView.tableFooterView = spinner
            delegate?.loadMoreNewsFromInfinityScroll()
            debugPrint("Loading more News...")
        }
    }
}
