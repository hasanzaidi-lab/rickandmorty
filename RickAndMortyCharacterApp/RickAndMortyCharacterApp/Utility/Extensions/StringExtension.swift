//
//  StringExtension.swift
//  RickAndMortyCharacterApp
//
//  Created by Hasan on 13/01/26.
//
import Foundation

extension String {
    func formatAPIDate() -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [
            .withInternetDateTime,
            .withFractionalSeconds
        ]

        guard let date = isoFormatter.date(from: self) else {
            return self
        }

        let displayFormatter = DateFormatter()
        displayFormatter.dateStyle = .medium
        displayFormatter.timeStyle = .none

        return displayFormatter.string(from: date)
    }

}
