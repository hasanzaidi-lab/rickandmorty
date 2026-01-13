//
//  s.swift
//  RickAndMortyCharacterApp
//
//  Created by Hasan on 13/01/26.
//

struct CharacterResponse: Decodable {
    let results: [CharacterResult]
}

struct CharacterResult: Identifiable, Decodable, Equatable {
    let id: Int
    let name: String
    let species: String
    let status: String
    let type: String
    let image: String
    let origin: Origin
    let created: String
}

struct Origin: Decodable, Equatable {
    let name: String
}
