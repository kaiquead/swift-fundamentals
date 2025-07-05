//
//  HttpClient.swift
//  swift-fundamentals
//
//  Created by Kaique Alves on 04/07/25.
//

import Foundation

protocol HttpClientProtocol {
    func makeRequest(
        endpoint: HttpClient.Endpoint,
        completion: @escaping (Result<Data, HttpClient.RequestError>) -> Void
    )
}

class HttpClient: HttpClientProtocol {
    
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }

    func makeRequest(
        endpoint: HttpClient.Endpoint,
        completion: @escaping (Result<Data, HttpClient.RequestError>) -> Void
    ) {
        // MARK: - Configuration
        
        guard let url = URL(string: endpoint.urlString) else {
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
        
        urlComponents.queryItems = endpoint.queryItems

        guard let urlWithComponents = urlComponents.url else {
            completion(.failure(.invalidURLComponents))
            return
        }

        var request = URLRequest(url: urlWithComponents)
        request.httpMethod = endpoint.method.rawValue
        request.httpBody = endpoint.body
        
        endpoint.headers?.forEach { key, value in
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
            debugPrint("URL: \(String(describing: httpResponse.url))")

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
