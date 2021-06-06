//
//  LectureTableViewController.swift
//  TermProjcet
//
//  Created by kpugame on 2021/06/06.
//

import UIKit
import YouTubePlayer

class LectureCell: UITableViewCell{
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var youtubeView: YouTubePlayerView!
}

class LectureTableViewController: UITableViewController {
    let titlelabel = ["1. 코딩 테스트 첫 걸음",
                      "2. 그리디 & 구현",
                      "3. DFS & BFS",
                      "4. 정렬 알고리즘",
                      "5. 이진 탐색",
                      "6. 다이나믹 프로그래밍",
                      "7. 최단 경로 알고리즘",
                      "8. 기타 그래프 이론",
                      "9. 자주 출제되는 기타 알고리즘",
                      "10. 개발형 코딩 테스트"]
    let videourl = ["https://www.youtube.com/watch?v=m-9pAwq1o3w",
                    "https://www.youtube.com/watch?v=2zjoKjt97vQ",
                    "https://www.youtube.com/watch?v=7C9RgOcvkvo",
                    "https://www.youtube.com/watch?v=KGyK-pNvWos",
                    "https://www.youtube.com/watch?v=94RC-DsGMLo",
                    "https://www.youtube.com/watch?v=5Lu34WIx2Us",
                    "https://www.youtube.com/watch?v=acqm9mM1P6o",
                    "https://www.youtube.com/watch?v=aOhhNFTIeFI",
                    "https://www.youtube.com/watch?v=cswJ1h-How0",
                    "https://www.youtube.com/watch?v=d8KPN79UAKA"]
    @IBOutlet var tableview: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableview.dataSource = self
        tableview.delegate = self
        tableview.rowHeight = 400
        tableview.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return videourl.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LectureCell", for: indexPath) as! LectureCell

        cell.fs_height = 300
        let youtubeurl = NSURL(string: videourl[indexPath.row])
        //let VideoURL = NSURL(string: "https://www.youtube.com/watch?v=WMweEpGlu_U")
        cell.youtubeView.loadVideoURL(youtubeurl! as URL)
        cell.title.text = titlelabel[indexPath.row]
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
