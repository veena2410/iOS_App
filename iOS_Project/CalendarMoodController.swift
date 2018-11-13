//
//  CalendarMoodController.swift
//  iOS_Project
//
//  Created by Veena Balakumar on 13/11/2018.
//  Copyright © 2018 SDU. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarMoodController : UIViewController  {
    
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var month: UILabel!
//    @IBOutlet weak var badDayBtn: UIButton!
    
    
    @IBOutlet weak var badDayBtn: UIButton!
    
    var goodDay = true

    let monthColor = UIColor.black
    let selectedMonthColor = UIColor.blue
    let outSideMonthColor = UIColor.gray
    
    let formatter = DateFormatter()
    
    let todaysDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView.calendarDataSource = self
        calendarView.calendarDelegate = self
        
        setupCalendarView()
        
        calendarView.scrollToDate(Date(), animateScroll: false)
        calendarView.selectDates([Date()])
    }
    
    func setupCalendarView() {
        //Setup calender spacing
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        //Setup labels
        calendarView.visibleDates(){(visibileDates) in
            self.setupViewFromCalendar(from: visibileDates)
            
        }
    }
    
    func handleCellTextColor(view: JTAppleCell?, cellState: CellState){
        guard let validCell = view as? CustomCell else { return }
        if cellState.isSelected{
            validCell.dateLabel.textColor = selectedMonthColor
        }else {
            if cellState.dateBelongsTo == .thisMonth {
                validCell.dateLabel.textColor = monthColor
                
            } else {
                validCell.dateLabel.textColor = outSideMonthColor
            }
        }
        
        formatter.dateFormat = "yyyy MM dd"
        
        let todaysDateString =  formatter.string(from: todaysDate)
        let monthDateString = formatter.string(from: cellState.date)
        
        if todaysDateString == monthDateString {
            validCell.dateLabel.textColor = UIColor.blue
        } else {
            validCell.dateLabel.textColor = cellState.isSelected ? UIColor.black : UIColor.black
        }
        
    }
    
    
    func handleCellSelected(view: JTAppleCell?, cellState: CellState){
        
        
        guard let validCell = view as? CustomCell else { return }
        if(goodDay==true){
            
            if cellState.isSelected {
                if(validCell.isDateSelected==false){
                    validCell.greenMarker.isHidden = false
                    validCell.redMarker.isHidden = true
                    validCell.isDateSelected = true
                } else {
                    validCell.greenMarker.isHidden = true
                    validCell.isDateSelected = false
                }
            }
            
        }
        
        
        if(goodDay==false){
            
            if cellState.isSelected {
                if(validCell.isDateSelected==false){
                    validCell.greenMarker.isHidden = true
                    validCell.redMarker.isHidden = false
                    validCell.isDateSelected = true
                } else {
                    validCell.redMarker.isHidden = true
                    validCell.isDateSelected = false
                }
            }
            
        }
    }
    
    
    @IBAction func badDay(_ sender: UIButton) {
                badDayBtn.isSelected = !badDayBtn.isSelected
                goodDay = false
        
                if(!badDayBtn.isSelected){
                    goodDay = true
                }
    }
    
    
//    @IBAction func badDay(_ sender: UIButton) {
//        badDayBtn.isSelected = !badDayBtn.isSelected
//        goodDay = false
//
//        if(!badDayBtn.isSelected){
//            goodDay = true
//        }
//    }
    
    func setupViewFromCalendar(from visibleDates: DateSegmentInfo){
        calendarView.visibleDates(){(visibileDates) in
            let date = visibileDates.monthDates.first!.date
            
            self.formatter.dateFormat = "yyyy"
            self.year.text = self.formatter.string(from: date)
            
            self.formatter.dateFormat = "MMMM"
            self.month.text = self.formatter.string(from: date)
        }
        
        
    }
    
}
    
    
extension CalendarMoodController: JTAppleCalendarViewDataSource {
    
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: "2018 01 01")!
        let endDate = formatter.date(from: "2050 12 31")!
        
        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate)
        return parameters
    }
}




extension CalendarMoodController: JTAppleCalendarViewDelegate {
    //Display the cell
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        // This function should have the same code as the cellForItemAt function
        let myCustomCell = cell as! CustomCell
        sharedFunctionToConfigureCell(myCustomCell: myCustomCell, cellState: cellState, date: date)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let myCustomCell = calendar.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        sharedFunctionToConfigureCell(myCustomCell: myCustomCell, cellState: cellState, date: date)
        handleCellSelected(view: myCustomCell, cellState: cellState)
        handleCellTextColor(view: myCustomCell, cellState: cellState)
        
        
        if cellState.isSelected {
            myCustomCell.greenMarker.isHidden = false
            myCustomCell.redMarker.isHidden = false
        } else {
            myCustomCell.greenMarker.isHidden = true
            myCustomCell.redMarker.isHidden = true
        }

     
        
        return myCustomCell
    }
    
    func sharedFunctionToConfigureCell(myCustomCell: CustomCell, cellState: CellState, date: Date) {
        myCustomCell.dateLabel.text = cellState.text
        // more code configurations
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        //     guard let validCell = cell as? CustomCell else {return }
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
        
    }
    
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        
        setupViewFromCalendar(from: visibleDates)
        
    }
}




