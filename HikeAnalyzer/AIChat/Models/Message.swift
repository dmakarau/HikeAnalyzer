//
//  Message.swift
//  AISocialChat
//
//  Created by Denis Makarau on 20.10.25.
//

import Foundation

struct Message: Identifiable, Equatable {
    let id = UUID().uuidString
    let text: String
    let isFromCurrentUser: Bool
}
