//
//  ViewController.swift
//  TermProjcet
//
//  Created by kpugame on 2021/05/05.
//

import UIKit
import FSCalendar
import Gifu
import DropDown

class ViewController: UIViewController {

    var edu = ""
    var code = ""
    @IBOutlet weak var calendarView: FSCalendar!
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        calendarView.locale = Locale(identifier: "ko_KR") //한국으로 설정
        calendarView.scrollEnabled = true // 스크롤 가능하게
        calendarView.scrollDirection = .vertical // 수직으로 스크롤
        calendarView.delegate = self
        calendarView.dataSource = self
        dateFormatter.dateFormat = "yyyyMMdd"
    }


}

extension ViewController : FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        switch dateFormatter.string(from: date) {
        case dateFormatter.string(from: Date()):
            return "오늘"
        default:
            return nil
        }
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        guard let InfoView = self.storyboard?.instantiateViewController(identifier: "InfoViewController") as? InfoViewController else { return }
        
        //InfoView.dateLabel.text = dateFormatter.string(from: date)
        InfoView.date = dateFormatter.string(from: date)
        InfoView.edu = edu
        InfoView.code = code
        self.present(InfoView, animated: true, completion: nil)
        
    }
}
