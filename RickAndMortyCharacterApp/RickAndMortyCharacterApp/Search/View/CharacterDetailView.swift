//
//  CharacterDetailView.swift
//  RickAndMortyCharacterApp
//
//  Created by Hasan on 13/01/26.
//
import SwiftUI

struct CharacterDetailView: View {
    let character: CharacterResult

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: character.image)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .accessibilityLabel(Text("\(character.name) character image"))
                .accessibilityAddTraits(.isImage)

                Text(character.name)
                    .font(.largeTitle)
                    .bold()
                    .accessibilityAddTraits(.isHeader)

                //Status
                infoRow(
                    title: "Status",
                    value: character.status
                )

                //Species
                infoRow(
                    title: "Species",
                    value: character.species
                )

                //Origin
                infoRow(
                    title: "Origin",
                    value: character.origin.name
                )
                
                //Created
                infoRow(
                    title: "Created",
                    value: character.created.formatAPIDate()
                )
            }
            .padding()
        }
        .navigationTitle(character.name)
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityElement(children: .contain)
    }

    // Reusable Accessible Row
    private func infoRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .font(.headline)
            Spacer()
            Text(value)
                .font(.body)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(Text(title))
        .accessibilityValue(Text(value))
    }
}
