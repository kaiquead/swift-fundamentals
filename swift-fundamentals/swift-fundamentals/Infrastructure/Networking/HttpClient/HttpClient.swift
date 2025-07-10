//
//  HttpClient.swift
//  swift-fundamentals
//
//  Created by Kaique Alves on 04/07/25.
//

import Foundation

protocol HttpClientProtocol {
    func makeRequest(
        requestConfiguration: HttpClient.RequestConfiguration,
        completion: @escaping (Result<Data, HttpClient.RequestError>) -> Void
    )
}

class HttpClient: HttpClientProtocol {
    
    // MARK: - Initialization
    
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }

    func makeRequest(
        requestConfiguration: HttpClient.RequestConfiguration,
        completion: @escaping (Result<Data, HttpClient.RequestError>) -> Void
    ) {
        // MARK: - Configuration
        
        guard let url = URL(string: requestConfiguration.urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        guard var urlComponents = URLComponents(
            url: url,
            resolvingAgainstBaseURL: false
        ) else {
            completion(.failure(.invalidURLComponents))
            return
        }
        
        urlComponents.queryItems = requestConfiguration.queryItems

        guard let urlWithComponents = urlComponents.url else {
            completion(.failure(.invalidURLComponents))
            return
        }

        var request = URLRequest(url: urlWithComponents)
        request.httpMethod = requestConfiguration.method.rawValue
        request.httpBody = requestConfiguration.body
        
        requestConfiguration.headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        // MARK: - API Call
        
        let task = session.dataTask(with: request) { data, response, error in
            // MARK: - Error case
            if let _ = error {
                completion(.failure(.networkError))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.responseError))
                return
            }

            debugPrint("Status Code: \(httpResponse.statusCode)")
            debugPrint("URL: \(httpResponse.url?.absoluteString ?? "")")

            guard (200..<300).contains(httpResponse.statusCode) else {
                completion(.failure(.apiError(statusCode: httpResponse.statusCode)))
                return
            }

            guard let data = data else {
                completion(.failure(.dataError))
                return
            }

            // MARK: - Sucess
            completion(.success(data))
        }

        task.resume()
    }
}
