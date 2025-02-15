//
//  Service.swift
//  RickAndMorty
//
//  Created by Engin Bolat on 24.01.2025.
//

import Foundation
import Alamofire

final class Service {
    static let shared = Service()
    
    private init() {}
    
    public func executeRequest<T: Codable>(
_ request: Request,
                                           expecting type: T.Type,
                                           method: HTTPMethod = .get,
                                           payload: [String: Any]? = nil,
complete: @escaping (
    Result<T,Error>
) -> Void
    ) {
        guard let url = request.url else {
            return complete(.failure(NetworkError.invalidURL))
        }
        guard let url = URL(string: url) else {
            return complete(.failure(NetworkError.invalidURL))
        }
        
        AF
            .request(
                url,
                method:method,
                parameters: payload,
                encoding: JSONEncoding.default
            )
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decodedResponse = try JSONDecoder().decode(
                            T.self,
                            from: data
                        )
                        complete(.success(decodedResponse))
                    } catch {
                        print(response.result)
                        self.handleDecodingError(error)
                    }
                case .failure(let error):
                    self.handleDecodingError(error)
                }
            }
    }
    
    // MARK - PRIVATE
    private func handleDecodingError(_ error: Error) {
        if let decodingError = error as? DecodingError {
            switch decodingError {
            case .typeMismatch(let key, let context):
                print(
                    "Type Mismatch for key: \(key), context: \(context)"
                )
            case .valueNotFound(let key, let context):
                print(
                    "Value not found for key: \(key), context: \(context)"
                )
            case .keyNotFound(let key, let context):
                print(
                    "Key '\(key)' not found: \(context.debugDescription)"
                )
                print("CodingPath: \(context.codingPath)")
            case .dataCorrupted(let context):
                print("Data corrupted: \(context)")
            @unknown default:
                print("Unknown Decoding Error")
            }
        } else {
            print("Error: \(error.localizedDescription)")
        }
    }
    
}

enum NetworkError : Error {
    case invalidURL
    case decodingError
}
