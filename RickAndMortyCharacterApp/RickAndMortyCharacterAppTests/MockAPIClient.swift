//
//  m.swift
//  RickAndMortyCharacterApp
//
//  Created by Hasan on 13/01/26.
//

import Testing
@testable import RickAndMortyCharacterApp

final class MockAPIClient: APIClientProtocol {

    enum MockError: Error {
        case failure
    }

    var result: Result<CharacterResponse, Error>

    init(result: Result<CharacterResponse, Error>) {
        self.result = result
    }

    func send<T>(_ request: T) async throws -> T.Response where T : APIRequest {
        switch result {
        case .success(let response):
            return response as! T.Response
        case .failure(let error):
            throw error
        }
    }
}

extension CharacterResult {

    static let mock = CharacterResult(
        id: 1,
        name: "Rick Sanchez",
        species: "Human",
        status: "Alive",
        type: "",
        image: "https://example.com/image.png",
        origin: Origin(name: "Earth"),
        created: "2017-11-04T18:48:46.250Z"
    )
}
