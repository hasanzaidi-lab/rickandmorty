//
//  CharacterSearchViewModel.swift
//  RickAndMortyCharacterApp
//
//  Created by Hasan on 13/01/26.
//
import Foundation
import Combine

enum CharacterSearchViewState: Equatable {
    case idle
    case loading
    case loaded([CharacterResult])
    case empty
    case error(String)
}

final class CharacterSearchViewModel: ObservableObject {

    @Published var searchText: String = ""
    @Published private(set) var state: CharacterSearchViewState = .idle

    private let apiClient: APIClientProtocol
    private var cancellables = Set<AnyCancellable>()
    private var searchTask: Task<Void, Never>?

    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
        bindSearch()
    }
    
    private func bindSearch() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .sink { [weak self] text in
                self?.performSearch(text: text, status: .all)
            }
            .store(in: &cancellables)
    }

    @MainActor
    private func performSearch(text: String, status: CharacterStatus) {
        searchTask?.cancel()

        guard !text.isEmpty else {
            state = .idle
            return
        }

        searchTask = Task {
            state = .loading
            do {
                let request = FetchCharactersRequest(
                    name: text)

                let response = try await apiClient.send(request)

                if response.results.isEmpty {
                    state = .empty
                } else {
                    state = .loaded(response.results)
                }

            } catch {
                state = .error("Unable to load characters.")
            }
        }
    }
}
