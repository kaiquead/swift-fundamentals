//
//  HomeWorker.swift
//  swift-fundamentals
//
//  Created by Kaique Alves on 07/07/25.
//

import Foundation

protocol HomeWorkerProtocol {
    func makeInitialNewsRequest(page: Int, completion: @escaping (HomeWorker.MakeInitialNewsResult) -> Void)
}

class HomeWorker: HomeWorkerProtocol {
    
    // MARK: - Typealias for result
    
    typealias MakeInitialNewsResult = Result<HomeNews, HttpClient.RequestError>
    
    // MARK: - Initialization
    
    let httpClient: HttpClientProtocol
    let newsApiKeyManager: NewsAPIKeyManagerProtocol
    
    init(httpClient: HttpClientProtocol = HttpClient(), newsApiKeyManager: NewsAPIKeyManagerProtocol = NewsAPIKeyManager.shared) {
        self.httpClient = httpClient
        self.newsApiKeyManager = newsApiKeyManager
    }
    
    // MARK: - Requests
    
    func makeInitialNewsRequest(page: Int, completion: @escaping (HomeWorker.MakeInitialNewsResult) -> Void) {
        let queryItems = [
            URLQueryItem(name: "q", value: "noticias"),
            URLQueryItem(name: "language", value: "pt"),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "pageSize", value: "30"),
            URLQueryItem(name: "apiKey", value: newsApiKeyManager.getAPIKey())
        ]
        
        let requestConfiguration = HttpClient.RequestConfiguration(urlString: ApiConstants.newsApiBaseUrlString, queryItems: queryItems)
        
        httpClient.makeRequest(requestConfiguration: requestConfiguration) { result in
            switch result {
            case .success(let data):
                guard let decoded = try? JSONDecoder().decode(HomeNews.self, from: data) else {
                    completion(.failure(.decodeError))
                    return
                }
                completion(.success(decoded))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
