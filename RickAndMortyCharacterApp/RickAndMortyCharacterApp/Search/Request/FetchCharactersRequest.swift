//
//  FetchCharactersRequest.swift
//  RickAndMortyCharacterApp
//
//  Created by Hasan on 13/01/26.
//

import Foundation

enum CharacterStatus: String, CaseIterable, Identifiable {
    case all, alive, dead, unknown
    var id: String { rawValue }
}

struct FetchCharactersRequest: APIRequest {

    typealias Response = CharacterResponse

    private let name: String
    init(name: String) {
        self.name = name
    }

    var urlRequest: URLRequest {
        var components = URLComponents(string: "https://rickandmortyapi.com/api/character")!
        components.queryItems = [
            URLQueryItem(name: "name", value: name)
        ].compactMap { $0 }

        return URLRequest(url: components.url!)
    }
}
