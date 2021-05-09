//
//  LogoViewController.swift
//  TermProjcet
//
//  Created by kpugame on 2021/05/09.
//

import UIKit
import Gifu

class LogoViewController: UIViewController {

    @IBOutlet weak var logoImage: GIFImageView!
    @IBOutlet weak var startButton: UIButton!
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
