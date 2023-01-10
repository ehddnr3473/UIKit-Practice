//
//  CalendarViewController.swift
//  PlayOn_UIKit
//
//  Created by 김동욱 on 2023/01/10.
//

import UIKit

class CalendarViewController: UIViewController {

    private var calendarView: UICalendarView!
    private let database = EventDatabase()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // configure
        let calendarView = UICalendarView()
        let gregorianCalendar = Calendar(identifier: .gregorian)
        calendarView.calendar = gregorianCalendar
        let dateSelection = UICalendarSelectionSingleDate(delegate: database)
        calendarView.selectionBehavior = dateSelection
        calendarView.locale = .current
        calendarView.fontDesign = .rounded
        
        // range
        let fromDataComponents = DateComponents(calendar: Calendar(identifier: .gregorian), year: 2023, month: 1, day: 1)
        let endDateComponents = DateComponents(calendar: Calendar(identifier: .gregorian), year: 2023, month: 12, day: 1)
        calendarView.visibleDateComponents = DateComponents(calendar: Calendar(identifier: .gregorian), year: 2023, month: 1, day: 1)
        
        guard let fromDate = fromDataComponents.date, let endDate = endDateComponents.date else { return }
        let calendarViewDateRange = DateInterval(start: fromDate, end: endDate)
        calendarView.availableDateRange = calendarViewDateRange
        
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        self.calendarView = calendarView
        view.addSubview(calendarView)
        calendarView.delegate = database
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        calendarView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        calendarView.center = view.center
    }
}

#if DEBUG

import SwiftUI

struct CalendarViewControllerRepresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        // return ViewController
        CalendarViewController()
    }
}

struct ViewControllerRepresentablePreviewProvider: PreviewProvider {
    static var previews: some View {
        CalendarViewControllerRepresentable()
    }
}

#endif
