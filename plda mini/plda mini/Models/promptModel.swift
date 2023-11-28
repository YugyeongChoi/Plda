//
//  promptModel.swift
//  Plda mini
//
//  Created by 최유경 on 11/28/23.
//

import Foundation

struct Prompt: Codable {
    let prompt_id: Int
    let feedback: Int
    let prompt: String
}

func requestGetPrompts() async throws -> [Prompt] {
    let urlString = "http://61.254.228.107:1207/prompts/get"

    guard let url = URL(string: urlString) else { throw PostErr.urlError }

    var request = URLRequest(url: url)

    request.httpMethod = "GET"

    let (data, _) = try await URLSession.shared.data(for: request)

    print(data)

    do {
        let decoder = JSONDecoder()
        return try decoder.decode([Prompt].self, from: data)
    }
    catch {
        print("decode fail")
        throw PostErr.decodeError
    }
}
