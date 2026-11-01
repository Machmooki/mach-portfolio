//
//  PortfolioModels.swift
//  iOS_App3
//
//  Created by Mach Suwanpatikorn on 31/10/2569 BE.
//

import Foundation

struct PortfolioData: Codable {
    let profile: Profile
    let statementOfPurpose: StatementOfPurpose
    let projects: [Project]
    let certificates: [Certificate]

    enum CodingKeys: String, CodingKey {
        case profile = "Profile"
        case statementOfPurpose = "StatementOfPurpose"
        case projects = "Projects"
        case certificates = "Certificates"
    }

    var visibleProjects: [Project] {
        let enabled = projects.filter { $0.isEnabled }
        return Array(enabled.prefix(5))
    }
}

struct Profile: Codable {
    let name: String
    let title: String
    let introduction: String
    let background: String?
    let education: [String]
    let skills: [String]
    let interests: [String]
    let profileImageName: String
    let introVideoName: String

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case title = "Title"
        case introduction = "Introduction"
        case background = "Background"
        case education = "Education"
        case skills = "Skills"
        case interests = "Interests"
        case profileImageName = "ProfileImageName"
        case introVideoName = "IntroVideoName"
    }
}

struct StatementOfPurpose: Codable {
    let eyebrow: String
    let mainTitle: String
    let subtitle: String
    let introduction: String
    let sections: [Section]
    let closingStatement: String
    let closingNote: String

    enum CodingKeys: String, CodingKey {
        case eyebrow = "Eyebrow"
        case mainTitle = "MainTitle"
        case subtitle = "Subtitle"
        case introduction = "Introduction"
        case sections = "Sections"
        case closingStatement = "ClosingStatement"
        case closingNote = "ClosingNote"
    }

    struct Section: Codable {
        let number: String
        let icon: String
        let title: String
        let description: String

        enum CodingKeys: String, CodingKey {
            case number = "SectionNumber"
            case icon = "SectionIcon"
            case title = "SectionTitle"
            case description = "SectionDescription"
        }
    }
}

struct Project: Codable {
    let name: String
    let description: String
    let category: String
    let technologies: [String]
    let imageName: String
    let urlString: String
    let isEnabled: Bool

    enum CodingKeys: String, CodingKey {
        case name = "ProjectName"
        case description = "ProjectDescription"
        case category = "ProjectCategory"
        case technologies = "Technologies"
        case imageName = "ProjectImageName"
        case urlString = "ProjectURL"
        case isEnabled = "IsEnabled"
    }

    var url: URL? {
        guard let url = URL(string: urlString), url.scheme == "https" || url.scheme == "http" else {
            return nil
        }
        return url
    }
}

struct Certificate: Codable {
    let name: String
    let description: String
    let imageName: String

    enum CodingKeys: String, CodingKey {
        case name = "CertificateName"
        case description = "CertificateDescription"
        case imageName = "CertificateImageName"
    }
}
