//
//  InfoViewController.swift
//  TermProjcet
//
//  Created by kpugame on 2021/05/05.
//

import UIKit

class InfoViewController: UIViewController, XMLParserDelegate {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var menuLabel: UILabel!
    @IBOutlet weak var calLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var calInfoLabel: UILabel!
    
    
    var parser = XMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    
    var title1 = NSMutableString()
    var kind = NSMutableString()
    var menu = NSMutableString()
    var ori = NSMutableString()
    var cal = NSMutableString()
    var calinfo = NSMutableString()
    
    var edu = ""
    var code = ""
    var date = ""
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beginParsing()
        let tmp:String = menu as String
        let tmp2:String = ori as String
        let tmp3:String = calinfo as String
        dateLabel.text = makeDate(str: date)
        menuLabel.text = tmp.replacingOccurrences(of: "<br/>", with: "\n")
        originLabel.text = tmp2.replacingOccurrences(of: "<br/>", with: "\n")
        calLabel.text = cal as String
        calInfoLabel.text = tmp3.replacingOccurrences(of: "<br/>", with: "\n")
        // Do any additional setup after loading the view.
    }
    func makeDate(str: String) -> String {
        var str2 = str
        str2.insert("-", at: str2.index(str2.startIndex, offsetBy: 4))
        str2.insert("-", at: str2.index(str2.startIndex, offsetBy: 7))
        return str2
    }
    func beginParsing()
    {
        posts = []
        let NSedu = String(edu.filter{!" \n\t\r".contains($0)})
        let NScode = String(code.filter{!" \n\t\r".contains($0)})
        let url = "https://open.neis.go.kr/hub/mealServiceDietInfo?KEY=92f8da4aa880435a8d6241dc3d456fb2&Type=&pIndex=1&pSize=100&ATPT_OFCDC_SC_CODE=" + NSedu + "&SD_SCHUL_CODE=" + NScode + "&MLSV_YMD=" + date
        parser = XMLParser(contentsOf: (URL(string: url)!))!
        parser.delegate = self
        parser.parse()
        //schoolTableView!.reloadData()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        element = elementName as NSString
        if (elementName as NSString).isEqual(to: "result")
        {
            elements = NSMutableDictionary()
            elements = [:]
            title1 = NSMutableString()
            title1 = ""
            kind = NSMutableString()
            kind = ""
            menu = NSMutableString()
            menu = ""
            ori = NSMutableString()
            ori = ""
            cal = NSMutableString()
            cal = ""
            calinfo = NSMutableString()
            calinfo = ""
            
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if element.isEqual(to: "SCHUL_NM") {
            title1.append(string)
        } else if element.isEqual(to: "MMEAL_SC_NM") {
            kind.append(string)
        } else if element.isEqual(to: "DDISH_NM") {
            menu.append(string)
        } else if element.isEqual(to: "ORPLC_INFO") {
            ori.append(string)
        } else if element.isEqual(to: "CAL_INFO") {
            cal.append(string)
        } else if element.isEqual(to: "NTR_INFO") {
            calinfo.append(string)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if (elementName as NSString).isEqual(to: "result"){
            if !title1.isEqual(nil){
                elements.setObject(title1, forKey: "SCHUL_NM" as NSCopying)
            }
            if !kind.isEqual(nil){
                elements.setObject(kind, forKey: "MMEAL_SC_NM" as NSCopying)
            }
            if !menu.isEqual(nil){
                elements.setObject(menu, forKey: "DDISH_NM" as NSCopying)
            }
            if !ori.isEqual(nil){
                elements.setObject(ori, forKey: "ORPLC_INFO" as NSCopying)
            }
            if !cal.isEqual(nil){
                elements.setObject(cal, forKey: "CAL_INFO" as NSCopying)
            }
            if !calinfo.isEqual(nil){
                elements.setObject(calinfo, forKey: "NTR_INFO" as NSCopying)
            }
            
            
            posts.add(elements)
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
