//
//  LecturePageViewController.swift
//  TermProjcet
//
//  Created by kpugame on 2021/06/07.
//

import UIKit
import Tabman
import Pageboy

class LecturePageViewController: TabmanViewController {
    

    private var viewControllers: Array<UIViewController> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        let vc2 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Lecture1") as! LectureTableViewController
        let vc3 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Lecture2") as! LectureT2ableViewController
        let vc4 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Lecture3") as! LectureT3ableViewController
            
        viewControllers.append(vc2)
        viewControllers.append(vc3)
        viewControllers.append(vc4)
        
        self.dataSource = self

        // Create bar
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap // Customize

        // Add to view
        addBar(bar, dataSource: self, at: .top)
    }

}

extension LecturePageViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let item = TMBarItem(title: "")
        
        switch index {
            case 0:
                item.title = "코딩 테스트"
            case 1:
                item.title = "스마트폰 게임프로그래밍"
            case 2:
                item.title = "안드로이드 코틀린"
            default:
                item.title = "Page \(index)"
        }
        
        //item.image = UIImage(named: "image.png")
        // ↑↑ 이미지는 이따가 탭바 형식으로 보여줄 때 사용할 것이니 "이미지가 왜 있지?" 하지말고 넘어가주세요.
        
        return item
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }

    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}
