//
//  CharacterSearchView.swift
//  RickAndMortyCharacterApp
//
//  Created by Hasan on 13/01/26.
//

import SwiftUI

struct CharacterSearchView: View {

    @StateObject private var viewModel = CharacterSearchViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 8) {
                content
            }
            .navigationTitle("Characters")
            .searchable(
                text: $viewModel.searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Search characters"
            )
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle:
            emptyState("Start typing to search characters")
        case .loading:
            ProgressView("Searching…")
                .accessibilityLabel("Searching characters")
        case .empty:
            emptyState("No characters found")
        case .loaded(let characters):
            characterList(characters)
        case .error(let message):
            emptyState(message)
        }
    }

    private func emptyState(_ message: String) -> some View {
        VStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .font(.largeTitle)
                .foregroundStyle(.secondary)

            Text(message)
                .font(.body)
                .foregroundStyle(.secondary)
        }
        .padding()
        .accessibilityLabel(message)
    }

    private func characterList(_ characters: [CharacterResult]) -> some View {
        List(characters) { character in
            NavigationLink {
                CharacterDetailView(character: character)
            } label: {
                CharacterRow(character: character)
            }
        }
    }
}
