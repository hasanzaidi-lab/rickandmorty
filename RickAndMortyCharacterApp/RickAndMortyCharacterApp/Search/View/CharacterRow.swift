//
//  CharacterRow.swift
//  RickAndMortyCharacterApp
//
//  Created by Hasan on 13/01/26.
//
import SwiftUI

struct CharacterRow: View {

    let character: CharacterResult

    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: character.image)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 60, height: 60)
            .clipShape(Circle())
            .accessibilityLabel("Image of \(character.name)")

            VStack(alignment: .leading) {
                Text(character.name)
                    .font(.headline)
                    .accessibilityAddTraits(.isHeader)

                Text(character.species)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .accessibilityLabel("Species: \(character.species)")
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityHint("Tap to view character details")
    }
}
