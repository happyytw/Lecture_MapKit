//
//  MeasurmentFormatter.swift
//  Hello-Maps
//
//  Created by Taewon Yoon on 10/21/23.
//

import Foundation

extension MeasurementFormatter {
    
    static var distance: MeasurementFormatter {
        let formatter = MeasurementFormatter()
        formatter.unitStyle = .medium
        formatter.unitOptions = .naturalScale
        formatter.locale = Locale.current
        return formatter
    }
}
