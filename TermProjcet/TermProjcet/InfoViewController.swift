//
//  InfoViewController.swift
//  TermProjcet
//
//  Created by kpugame on 2021/05/05.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    var date : String
    
    required init?(coder aDecoder: NSCoder) {
        self.date = "2021-05-05"
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateLabel.text = date
        // Do any additional setup after loading the view.
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
