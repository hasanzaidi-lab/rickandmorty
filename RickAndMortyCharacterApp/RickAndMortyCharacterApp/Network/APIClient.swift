//
//  RestServiceManager.swift
//  RickAndMortyCharacterApp
//
//  Created by Hasan on 13/01/26.
//
import Foundation

protocol APIRequest {
    associatedtype Response: Decodable
    var urlRequest: URLRequest { get }
}

protocol APIClientProtocol {
    func send<T: APIRequest>(_ request: T) async throws -> T.Response
}

final class APIClient {

    private let session: URLSession
    private let decoder: JSONDecoder

    init(
        session: URLSession = .shared,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.session = session
        self.decoder = decoder
    }
}


extension APIClient: APIClientProtocol {
    func send<T: APIRequest>(_ request: T) async throws -> T.Response {
        let (data, response) = try await session.data(for: request.urlRequest)

        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }

        return try decoder.decode(T.Response.self, from: data)
    }
}
