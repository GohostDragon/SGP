//
//  LectureTableViewController.swift
//  TermProjcet
//
//  Created by kpugame on 2021/06/06.
//

import UIKit
import YouTubePlayer

class LectureCell2: UITableViewCell{
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var youtubeView: YouTubePlayerView!
}

class LectureT2ableViewController: UITableViewController {
    let titlelabel = ["1. 개발환경",
                      "2. A Guided Tour of XCODE",
                      "3. Introduction to XCODE 1부",
                      "4. Introduction to XCODE 2부",
                      "5. Swift Tutorial",
                      "6. Swift Tutorial 2",
                      "7. Swift Tutorial 3",
                      "8. Swift Tutorial 4",
                      "9. Swift Tutorial 5",
                      "10. Swift Tutorial 6"]
    let videourl = ["https://youtu.be/nZdvq6SN-zw",
                    "https://youtu.be/eD6bN2IeSkA",
                    "https://youtu.be/cTStvIZcdD4",
                    "https://youtu.be/rgyhIGu2bjc",
                    "https://youtu.be/2br3GvF6w0A",
                    "https://youtu.be/qr8YexmuCFw",
                    "https://youtu.be/ihbBzpCIES8",
                    "https://www.youtube.com/watch?v=Y1uHF26gItI",
                    "https://www.youtube.com/watch?v=4_wse_s1QYI",
                    "https://www.youtube.com/watch?v=zCLcXPPLB_I"]
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "LectureCell2", for: indexPath) as! LectureCell2

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
