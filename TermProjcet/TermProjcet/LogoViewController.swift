//
//  LogoViewController.swift
//  TermProjcet
//
//  Created by kpugame on 2021/05/09.
//

import UIKit
import Gifu
import Toast_Swift

class LogoViewController: UIViewController {

    @IBOutlet weak var logoImage: GIFImageView!
    @IBOutlet weak var startButton: UIButton!
    @IBAction func info(_ sender: Any) {
        self.view.makeToast("스마트폰게임 프로그래밍 텀프로젝트입니다.", duration: 2.0, point: CGPoint(x: 200, y: 500), title: "App 소개", image: UIImage(named: "hello.gif"), style: .init(), completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        logoImage.animate(withGIFNamed: "logobg")
        startButton.layer.cornerRadius = 10
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
