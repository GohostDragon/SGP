//
//  LectureViewController.swift
//  TermProjcet
//
//  Created by kpugame on 2021/06/05.
//

import UIKit
import YouTubePlayer

let videourl = ["https://www.youtube.com/watch?v=m-9pAwq1o3w",
                "https://www.youtube.com/watch?v=2zjoKjt97vQ",
                "https://www.youtube.com/watch?v=7C9RgOcvkvo",
                "https://www.youtube.com/watch?v=KGyK-pNvWos",
                "https://www.youtube.com/watch?v=94RC-DsGMLo",
                "https://www.youtube.com/watch?v=5Lu34WIx2Us"]

class LecturCell: UITableViewCell {
 
    @IBOutlet weak var test: UILabel!
}

class LectureViewController: UIViewController {

    @IBOutlet weak var youtube: YouTubePlayerView!
    
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        //let VideoURL = NSURL(string: "https://www.youtube.com/watch?v=WMweEpGlu_U")
        let VideoURL = NSURL(string: "https://www.youtube.com/watch?v=m-9pAwq1o3w")
        youtube.loadVideoURL(VideoURL! as URL)
        // Do any additional setup after loading the view.
        tableview.dataSource = self
        tableview.delegate = self
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

extension LectureViewController: UITableViewDelegate {
    
}

extension LectureViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videourl.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LectureCell", for: indexPath) as! LecturCell
        //let youtubeurl = NSURL(string: videourl[indexPath.row])
        cell.test.text = String(indexPath.row)
        print(indexPath.row)
        //let VideoURL = NSURL(string: "https://www.youtube.com/watch?v=WMweEpGlu_U")
        //cell.youtubeView.loadVideoURL(VideoURL! as URL)
        return cell
    }
}
