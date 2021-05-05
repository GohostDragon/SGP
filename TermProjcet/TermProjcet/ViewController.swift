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

    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var HelloImage: GIFImageView!
    @IBOutlet weak var selectEdu: UIButton!
    let dateFormatter = DateFormatter()
    let dropDown = DropDown()
    
    @IBAction func SelectItem(_ sender: Any) {
        dropDown.show()
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            selectEdu.setTitle(item, for: .normal)
            self.dropDown.clearSelection()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        calendarView.locale = Locale(identifier: "ko_KR") //한국으로 설정
        calendarView.scrollEnabled = true // 스크롤 가능하게
        calendarView.scrollDirection = .vertical // 수직으로 스크롤
        calendarView.delegate = self
        calendarView.dataSource = self
        dateFormatter.dateFormat = "yyyy-MM-dd"
        HelloImage.animate(withGIFNamed: "hello")
        
        dropDown.dataSource = ["서울특별시교육청","부산광역시교육청", "대구광역시교육청", "인천광역시교육청", "광주광역시교육청", "대전광역시교육청", "울산광역시교육청", "세종특별자치시교육청", "경기도교육청", "강원도교육청", "충청북도교육청", "충청남도교육청", "전라북도교육청", "전라남도교육청", "경상북도교육청", "경상남도교육청", "제주특별자치도교육청" ]
        dropDown.anchorView = selectEdu
        dropDown.bottomOffset = CGPoint(x: 0, y: (dropDown.anchorView?.plainView.bounds.height)!)
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
        self.present(InfoView, animated: true, completion: nil)
        
    }
}
