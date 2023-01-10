//
//  EventDatabase.swift
//  PlayOn_UIKit
//
//  Created by 김동욱 on 2023/01/10.
//

import Foundation
import UIKit

class EventDatabase: NSObject, UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        // 선택시 수행할 작업
    }
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, canSelectDate dateComponents: DateComponents?) -> Bool {
        return dateComponents != nil
    }
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter
    }()
    
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        guard let date = dateComponents.date else { return nil }
        if dateFormatter.string(from: date) == "2023.01.01" {
            return .image(UIImage(systemName: "x.circle"))
        } else if dateFormatter.string(from: date) == "2023.01.02" {
            return .default()
        } else if dateFormatter.string(from: date) == "2023.01.03" {
            return .customView {
                RedBackgroundView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            }
        }
        return nil
    }
    
    func calendarView(_ calendarView: UICalendarView, didChangeVisibleDateComponentsFrom previousDateComponents: DateComponents) {
        print("changed")
    }
}
