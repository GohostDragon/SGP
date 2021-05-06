//
//  SchoolSearchViewController.swift
//  TermProjcet
//
//  Created by kpugame on 2021/05/07.
//

import UIKit
import Gifu
import DropDown

class SchoolSearchViewController: UIViewController, XMLParserDelegate, UITableViewDataSource {

    @IBOutlet weak var eduButton: UIButton!
    @IBOutlet weak var schoollevelButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var searchText: UITextField!
    
    @IBOutlet weak var schoolTableView: UITableView!
    
    var eduDic:Dictionary = ["서울특별시교육청":"B10","부산광역시교육청":"C10", "대구광역시교육청":"D10", "인천광역시교육청":"E10", "광주광역시교육청":"F10", "대전광역시교육청":"G10", "울산광역시교육청":"H10", "세종특별자치시교육청":"I10", "경기도교육청":"J10", "강원도교육청":"K10", "충청북도교육청":"M10", "충청남도교육청":"N10", "전라북도교육청":"P10", "전라남도교육청":"Q10", "경상북도교육청":"R10", "경상남도교육청":"S10", "제주특별자치도교육청":"T10" ]
    
    let edudropDown = DropDown()
    let leveldropDown = DropDown()
    
    var parser = XMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    
    var title1 = NSMutableString()
    var date = NSMutableString()
    
    
    @IBAction func eduSelecet(_ sender: Any) {
        edudropDown.show()
        edudropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            eduButton.setTitle(item, for: .normal)
            self.edudropDown.clearSelection()
        }
    }
    
    @IBAction func schoolLevelSelect(_ sender: Any) {
        leveldropDown.show()
        edudropDown.hide()
        leveldropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            schoollevelButton.setTitle(item, for: .normal)
            self.leveldropDown.clearSelection()
        }
    }
    
    @IBAction func schoolSearch(_ sender: Any) {
        beginParsing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        eduButton.layer.borderWidth = 2
        eduButton.layer.borderColor = UIColor.black.cgColor
        eduButton.layer.cornerRadius = 10
        
        schoollevelButton.layer.borderWidth = 2
        schoollevelButton.layer.borderColor = UIColor.black.cgColor
        schoollevelButton.layer.cornerRadius = 10
        //schoolTableView.isHidden = true
        
        edudropDown.dataSource = ["서울특별시교육청","부산광역시교육청", "대구광역시교육청", "인천광역시교육청", "광주광역시교육청", "대전광역시교육청", "울산광역시교육청", "세종특별자치시교육청", "경기도교육청", "강원도교육청", "충청북도교육청", "충청남도교육청", "전라북도교육청", "전라남도교육청", "경상북도교육청", "경상남도교육청", "제주특별자치도교육청" ]
        edudropDown.anchorView = eduButton
        edudropDown.bottomOffset = CGPoint(x: 0, y: (edudropDown.anchorView?.plainView.bounds.height)!)
        
        leveldropDown.dataSource = ["전체", "고등학교","중학교", "초등학교", "특수학교" ]
        leveldropDown.anchorView = schoollevelButton
        leveldropDown.bottomOffset = CGPoint(x: 0, y: (leveldropDown.anchorView?.plainView.bounds.height)!)
        
    }
    
    func beginParsing()
    {
        let eduurl = eduDic[eduButton.currentTitle!]
        var levelurl = schoollevelButton.currentTitle ?? "전체"
        if levelurl == "전체" {
            levelurl = ""
        } else {
            levelurl = "&SCHUL_KND_SC_NM="+levelurl.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        }
        var searchurl = searchText.text ?? ""
        if searchurl != "" {
            searchurl = "&SCHUL_NM=" + searchurl.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        }
        posts = []
        parser = XMLParser(contentsOf: (URL(string: "https://open.neis.go.kr/hub/schoolInfo?KEY=92f8da4aa880435a8d6241dc3d456fb2&Type=&pIndex=1&pSize=100&ATPT_OFCDC_SC_CODE="+eduurl!+levelurl+searchurl)!))!
        parser.delegate = self
        parser.parse()
        schoolTableView!.reloadData()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        element = elementName as NSString
        if (elementName as NSString).isEqual(to: "row")
        {
            elements = NSMutableDictionary()
            elements = [:]
            title1 = NSMutableString()
            title1 = ""
            date = NSMutableString()
            date = ""
            
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if element.isEqual(to: "SCHUL_NM") {
            title1.append(string)
        } else if element.isEqual(to: "ORG_RDNMA") {
            date.append(string)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if (elementName as NSString).isEqual(to: "row"){
            if !title1.isEqual(nil){
                elements.setObject(title1, forKey: "SCHUL_NM" as NSCopying)
            }
            if !date.isEqual(nil){
                elements.setObject(date, forKey: "ORG_RDNMA" as NSCopying)
            }
            
            posts.add(elements)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "SCHUL_NM") as! NSString as String
        cell.detailTextLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "ORG_RDNMA") as! NSString as String
        return cell
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
