//
//  LectureTableViewController.swift
//  TermProjcet
//
//  Created by kpugame on 2021/06/06.
//

import UIKit
import YouTubePlayer

class LectureCell3: UITableViewCell{
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var youtubeView: YouTubePlayerView!
}

class LectureT3ableViewController: UITableViewController {
    let titlelabel = ["안드로이드 코틀린 앱 만들기 #1",
                      "안드로이드 코틀린 앱 만들기 #2",
                      "안드로이드 코틀린 앱 만들기 #3",
                      "안드로이드 코틀린 앱 만들기 #4",
                      "안드로이드 코틀린 앱 만들기 #5",
                      "안드로이드 코틀린 앱 만들기 #6",
                      "안드로이드 코틀린 앱 만들기 #7",
                      "안드로이드 코틀린 앱 만들기 #8",
                      "안드로이드 코틀린 앱 만들기 #9",
                      "안드로이드 코틀린 앱 만들기 #10"]
    let videourl = ["https://www.youtube.com/watch?v=IaXhn_I_ziY&list=PLC51MBz7PMywN2GJ53aF0UO5fnHGjW35a",
                    "https://www.youtube.com/watch?v=J-PsYQlgPWw&list=PLC51MBz7PMywN2GJ53aF0UO5fnHGjW35a&index=2",
                    "https://www.youtube.com/watch?v=oXIeBhV06-Y&list=PLC51MBz7PMywN2GJ53aF0UO5fnHGjW35a&index=3",
                    "https://www.youtube.com/watch?v=fmiwEfFrjsM&list=PLC51MBz7PMywN2GJ53aF0UO5fnHGjW35a&index=4",
                    "https://www.youtube.com/watch?v=ao0Iqfhy0oo&list=PLC51MBz7PMywN2GJ53aF0UO5fnHGjW35a&index=5",
                    "https://www.youtube.com/watch?v=ALTFLXKiPUY&list=PLC51MBz7PMywN2GJ53aF0UO5fnHGjW35a&index=6",
                    "https://www.youtube.com/watch?v=cyqgR8VTC1Y&list=PLC51MBz7PMywN2GJ53aF0UO5fnHGjW35a&index=7",
                    "https://www.youtube.com/watch?v=z0ha16-oz7I&list=PLC51MBz7PMywN2GJ53aF0UO5fnHGjW35a&index=8",
                    "https://www.youtube.com/watch?v=inprJiLDUIU&list=PLC51MBz7PMywN2GJ53aF0UO5fnHGjW35a&index=9",
                    "https://www.youtube.com/watch?v=inprJiLDUIU&list=PLC51MBz7PMywN2GJ53aF0UO5fnHGjW35a&index=10"]
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "LectureCell3", for: indexPath) as! LectureCell3

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
