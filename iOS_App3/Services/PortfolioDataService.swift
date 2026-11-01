//
//  PortfolioDataService.swift
//  iOS_App3
//
//  Created by Mach Suwanpatikorn on 31/10/2569 BE.
//

import Foundation

class PortfolioDataService {

    static let shared = PortfolioDataService()

    var data: PortfolioData?

    private init() {
        guard let url = Bundle.main.url(forResource: "PortfolioData", withExtension: "plist") else {
            print("PortfolioData.plist not found")
            return
        }
        do {
            let fileData = try Data(contentsOf: url)
            data = try PropertyListDecoder().decode(PortfolioData.self, from: fileData)
        } catch {
            print("Error reading PortfolioData.plist: \(error)")
        }
    }
}
