//
//  String+DecodeContent.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 23.11.2022.
//

import Foundation

extension String {
    func base64Decode() -> String? {
        let parsed = self.replacingOccurrences(of: "\n", with: "")
        guard let data = Data(base64Encoded: parsed) else { return nil }
        guard let content = String(data: data, encoding: .utf8) else { return nil }
        
        return content
    }
}
