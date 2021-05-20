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
    var locationName = NSMutableString()
    var edu = NSMutableString()
    var code = NSMutableString()
    var engTitle = NSMutableString()
    var level = NSMutableString()
    var pbpr = NSMutableString()
    var addr = NSMutableString()
    var tel = NSMutableString()
    var site = NSMutableString()
    var jender = NSMutableString()
    var fax = NSMutableString()
    var kind = NSMutableString()
    var estdate = NSMutableString()
    var holiday = NSMutableString()
    var educode = NSMutableString()
    
    @IBAction func doneToSchoolSearchViewController(segue:UIStoryboardSegue){
    }
    
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
        schoolTableView.isHidden = false
        beginParsing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //schoolTableView.isHidden = true
        
        eduButton.layer.borderWidth = 2
        eduButton.layer.borderColor = UIColor.black.cgColor
        eduButton.layer.cornerRadius = 10
        
        schoollevelButton.layer.borderWidth = 2
        schoollevelButton.layer.borderColor = UIColor.black.cgColor
        schoollevelButton.layer.cornerRadius = 10
        
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
            locationName = NSMutableString()
            edu = NSMutableString()
            code = NSMutableString()
            engTitle = NSMutableString()
            level = NSMutableString()
            pbpr = NSMutableString()
            addr = NSMutableString()
            tel = NSMutableString()
            site = NSMutableString()
            jender = NSMutableString()
            fax = NSMutableString()
            kind = NSMutableString()
            estdate = NSMutableString()
            holiday = NSMutableString()
            educode = NSMutableString()
            
            title1 = ""
            locationName = ""
            edu = ""
            code = ""
            engTitle = ""
            level = ""
            pbpr = ""
            addr = ""
            tel = ""
            site = ""
            jender = ""
            fax = ""
            kind = ""
            estdate = ""
            holiday = ""
            educode = ""
            
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if element.isEqual(to: "SCHUL_NM") {
            title1.append(string)
        } else if element.isEqual(to: "LCTN_SC_NM") {
            locationName.append(string)
        }
        else if element.isEqual(to: "ATPT_OFCDC_SC_NM") {
            edu.append(string)
        }
        else if element.isEqual(to: "SD_SCHUL_CODE") {
            code.append(string)
        }
        else if element.isEqual(to: "ENG_SCHUL_NM") {
            engTitle.append(string)
        }
        else if element.isEqual(to: "SCHUL_KND_SC_NM") {
            level.append(string)
        }
        else if element.isEqual(to: "FOND_SC_NM") {
            pbpr.append(string)
        }
        else if element.isEqual(to: "ORG_RDNMA") {
            addr.append(string)
        }
        else if element.isEqual(to: "ORG_TELNO") {
            tel.append(string)
        }
        else if element.isEqual(to: "HMPG_ADRES") {
            site.append(string)
        }
        else if element.isEqual(to: "COEDU_SC_NM") {
            jender.append(string)
        }
        else if element.isEqual(to: "ORG_FAXNO") {
            fax.append(string)
        }
        else if element.isEqual(to: "HS_SC_NM") {
            kind.append(string)
        }
        else if element.isEqual(to: "FOND_YMD") {
            estdate.append(string)
        }
        else if element.isEqual(to: "FOAS_MEMRD") {
            holiday.append(string)
        }
        else if element.isEqual(to: "ATPT_OFCDC_SC_CODE") {
            educode.append(string)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if (elementName as NSString).isEqual(to: "row"){
            if !title1.isEqual(nil){
                elements.setObject(title1, forKey: "SCHUL_NM" as NSCopying)
            }
            if !locationName.isEqual(nil){
                elements.setObject(locationName, forKey: "LCTN_SC_NM" as NSCopying)
            }
            if !edu.isEqual(nil){
                elements.setObject(edu, forKey: "ATPT_OFCDC_SC_NM" as NSCopying)
            }
            if !code.isEqual(nil){
                elements.setObject(code, forKey: "SD_SCHUL_CODE" as NSCopying)
            }
            if !engTitle.isEqual(nil){
                elements.setObject(engTitle, forKey: "ENG_SCHUL_NM" as NSCopying)
            }
            if !level.isEqual(nil){
                elements.setObject(level, forKey: "SCHUL_KND_SC_NM" as NSCopying)
            }
            if !pbpr.isEqual(nil){
                elements.setObject(pbpr, forKey: "FOND_SC_NM" as NSCopying)
            }
            if !addr.isEqual(nil){
                elements.setObject(addr, forKey: "ORG_RDNMA" as NSCopying)
            }
            if !tel.isEqual(nil){
                elements.setObject(tel, forKey: "ORG_TELNO" as NSCopying)
            }
            if !site.isEqual(nil){
                elements.setObject(site, forKey: "HMPG_ADRES" as NSCopying)
            }
            if !jender.isEqual(nil){
                elements.setObject(jender, forKey: "COEDU_SC_NM" as NSCopying)
            }
            if !fax.isEqual(nil){
                elements.setObject(fax, forKey: "ORG_FAXNO" as NSCopying)
            }
            if !kind.isEqual(nil){
                elements.setObject(kind, forKey: "HS_SC_NM" as NSCopying)
            }
            if !estdate.isEqual(nil){
                elements.setObject(estdate, forKey: "FOND_YMD" as NSCopying)
            }
            if !holiday.isEqual(nil){
                elements.setObject(holiday, forKey: "FOAS_MEMRD" as NSCopying)
            }
            if !educode.isEqual(nil){
                elements.setObject(educode, forKey: "ATPT_OFCDC_SC_CODE" as NSCopying)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToSchoolInfo" {
            if let sgCell = sender as? UITableViewCell {
                let indexPath = schoolTableView.indexPath(for: sgCell)
                let sctitle = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "SCHUL_NM") as! NSString as String
                let sclocationName = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "LCTN_SC_NM") as! NSString as String
                let scedu = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "ATPT_OFCDC_SC_NM") as! NSString as String
                let sccode = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "SD_SCHUL_CODE") as! NSString as String
                let scengTitle = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "ENG_SCHUL_NM") as! NSString as String
                let sclevel = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "SCHUL_KND_SC_NM") as! NSString as String
                let scpbpr = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "FOND_SC_NM") as! NSString as String
                let scaddr = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "ORG_RDNMA") as! NSString as String
                let sctel = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "ORG_TELNO") as! NSString as String
                let scsite = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "HMPG_ADRES") as! NSString as String
                let scjender = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "COEDU_SC_NM") as! NSString as String
                let scfax = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "ORG_FAXNO") as! NSString as String
                let sckind = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "HS_SC_NM") as! NSString as String
                let scestdate = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "FOND_YMD") as! NSString as String
                let scholiday = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "FOAS_MEMRD") as! NSString as String
                let sceducode = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "ATPT_OFCDC_SC_CODE") as! NSString as String
                if let target = segue.destination as? UINavigationController, let schoolInfoViewController = target.topViewController as? SchoolInfoViewController {
                    let NSschoolcode = String(sccode.filter{!" \n\t\r".contains($0)})
                    schoolInfoViewController.url = "https://open.neis.go.kr/hub/schoolInfo?KEY=92f8da4aa880435a8d6241dc3d456fb2&Type=&pIndex=1&pSize=100&SD_SCHUL_CODE="+NSschoolcode
                    schoolInfoViewController.schoolData = CSchool(edu: scedu as String, code: sccode as String, title: sctitle as String, engTitle: scengTitle as String, level: sclevel as String, locationName: sclocationName as String, pbpr: scpbpr as String, addr: scaddr as String, tel: sctel as String, site: scsite as String, jender: scjender as String, fax: scfax as String, kind: sckind as String, estdate: scestdate as String, holiday: scholiday as String, educode: sceducode as String)
                }
            }
        }
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
