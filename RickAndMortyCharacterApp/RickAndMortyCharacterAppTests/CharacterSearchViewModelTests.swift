//
//  CharacterSearchViewModelTests.swift
//  RickAndMortyCharacterAppTests
//
//  Created by Hasan on 13/01/26.
//

import XCTest
@testable import RickAndMortyCharacterApp

final class CharacterSearchViewModelTests: XCTestCase {

    private func makeViewModel(
        result: Result<CharacterResponse, Error>
    ) -> CharacterSearchViewModel {
        let apiClient = MockAPIClient(result: result)
        return CharacterSearchViewModel(apiClient: apiClient)
    }

    @MainActor
    func test_emptySearch_keepsStateIdle() async {
        let viewModel = makeViewModel(result: .success(.init(results: [.mock])))

        viewModel.searchText = ""

        try? await Task.sleep(nanoseconds: 400_000_000)

        XCTAssertEqual(viewModel.state, .idle)
    }

    @MainActor
    func test_successfulSearch_setsLoadedState() async {
        let viewModel = makeViewModel(
            result: .success(.init(results: [.mock]))
        )

        viewModel.searchText = "Rick"

        try? await Task.sleep(nanoseconds: 400_000_000)

        XCTAssertEqual(viewModel.state, .loaded([.mock]))
    }

    @MainActor
    func test_searchWithNoResults_setsEmptyState() async {
        let viewModel = makeViewModel(
            result: .success(.init(results: []))
        )

        viewModel.searchText = "Unknown"

        try? await Task.sleep(nanoseconds: 400_000_000)

        XCTAssertEqual(viewModel.state, .empty)
    }

    @MainActor
    func test_searchFailure_setsErrorState() async {
        let viewModel = makeViewModel(
            result: .failure(MockAPIClient.MockError.failure)
        )

        viewModel.searchText = "Rick"

        try? await Task.sleep(nanoseconds: 400_000_000)

        XCTAssertEqual(viewModel.state, .error("Unable to load characters."))
    }
}
