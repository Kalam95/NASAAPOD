//
//  Date+Extensions.swift
//  NasaAPOD
//
//  Created by Mehboob on 16/10/21.
//

import Foundation

/// date formate
public enum DateFormat: String {
    case dd_MMM_yyyy = "dd MMM, yyyy"
    case yyyy_MM_dd = "yyyy-MM-dd"
    case hhmm_a = "h:mm a"
}

extension String {
    
    /// Get date object from string formated date
    /// - Parameter format: format of the date in string
    /// - Returns: date object if conversion is siuccessfull
    public func getDate(format: DateFormat) -> Date? {
        let dateformater = DateFormatter()
        dateformater.dateFormat = format.rawValue
        let date = dateformater.date(from: self)
        return date
    }
    
    
    /// Change string date value to one fromate to another
    /// - Parameters:
    ///   - currentFormat: formate the date strings is in currenly
    ///   - changedFormat: required date format
    /// - Returns: string date value in required format
    public func changeDateFormat(fromFromat currentFormat: DateFormat, toFormat changedFormat: DateFormat ) -> String {
        let dateString = self.trimmingCharacters(in: .whitespacesAndNewlines)
        if dateString.isEmpty {
            return dateString
        }
        let date = dateString.getDate(format: currentFormat)
        return date?.getString(format: changedFormat) ?? self
    }
}

extension Date {
    
    /// Method to convert date object into date string in the formate provided
    /// - Parameter format: format in which the date string is required
    /// - Returns: string date value
    public func getString(format: DateFormat) -> String {
        let dateformater = DateFormatter()
        dateformater.dateFormat = format.rawValue
        return dateformater.string(from: self)
    }
}
