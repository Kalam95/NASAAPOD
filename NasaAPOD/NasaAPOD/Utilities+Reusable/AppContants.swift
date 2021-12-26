//
//  AppContants.swift
//  Task2
//
//  Created by mehboob Alam.
//

import Foundation

/// An enum for app urls, there can be many wasy to do such things like creating an Config file, which is do in generat but i chose to use this as its just an assignemnt and conif file is not required.
enum AppURL: String {
    case base = "https://api.nasa.gov/planetary/"
}

enum APIKey: String {
    case date
    case api_key
    case count
    case thumbs
    case startDate = "start_date"
    case endDate = "end_date"
}

enum APIEndPoints: String {
    case apod
}

// GENERAL Constants
let API_KEY = "NQ6gscfYqxm4WA7POQKWfDRPokF98VJ5SLhceEnc"

