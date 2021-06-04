//
//  SchoolSearchViewController.swift
//  TermProjcet
//
//  Created by kpugame on 2021/05/07.
//

import UIKit
import Gifu
import DropDown
import Speech

class AcademySearchViewController: UIViewController, XMLParserDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var eduButton: UIButton!
    @IBOutlet weak var schoollevelButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var speechButton: UIButton!
    
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
    var acatotal = NSMutableString()
    var state = NSMutableString()
    var addr = NSMutableString()
    var subjectkind = NSMutableString()
    var subjectlist = NSMutableString()
    var subject = NSMutableString()
    var fare = NSMutableString()
    var kind = NSMutableString()
    var estdate = NSMutableString()

    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ko-KR"))!
    private var speechRecognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var speechRecognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    @IBAction func speechSearching(_ sender: Any) {
        if audioEngine.isRunning {
            audioEngine.stop()
            speechRecognitionRequest?.endAudio()
            speechButton.tintColor = UIColor.black
        } else {
            try! startSession()
            speechButton.tintColor = UIColor.gray
        }
    }
    
    func startSession() throws {
        if let recognitionTask = speechRecognitionTask {
            recognitionTask.cancel()
            self.speechRecognitionTask = nil
        }
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(AVAudioSession.Category.record)
        speechRecognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = speechRecognitionRequest else
            { fatalError("SFSpeechAudioBufferRecognitionRequest object creation failed") }
        
        let inputNode = audioEngine.inputNode
        recognitionRequest.shouldReportPartialResults = true
        speechRecognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
            var finished = false
            if let result = result {
                self.searchText.text = result.bestTranscription.formattedString
                finished = result.isFinal
            }
            
            if error != nil || finished {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                self.speechRecognitionRequest = nil
                self.speechRecognitionTask = nil
                self.speechButton.isEnabled = true
            }
        }
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.speechRecognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        try audioEngine.start()
    }
    
    func authorizeSR(){
        SFSpeechRecognizer.requestAuthorization { authStatus in
            OperationQueue.main.addOperation {
                switch authStatus{
                case .authorized:
                    self.speechButton.isEnabled = true
                    
                case .denied:
                    self.speechButton.isEnabled = false
                    self.speechButton.setTitle("Speech recognition access denied by user", for: .disabled)
                    
                case .restricted:
                    self.speechButton.isEnabled = false
                    self.speechButton.setTitle("Speech recognition restricted on device", for: .disabled)
                    
                case .notDetermined:
                    self.speechButton.isEnabled = false
                    self.speechButton.setTitle("Speech recognition not authorized", for: .disabled)
                @unknown default:
                    break
                }
            }
        }
    }
    
    @IBAction func doneToAcademySearchViewController(segue:UIStoryboardSegue){
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
        
        /*
        schoollevelButton.layer.borderWidth = 2
        schoollevelButton.layer.borderColor = UIColor.black.cgColor
        schoollevelButton.layer.cornerRadius = 10
         */
        //schoolTableView.isHidden = true
        
        edudropDown.dataSource = ["서울특별시교육청","부산광역시교육청", "대구광역시교육청", "인천광역시교육청", "광주광역시교육청", "대전광역시교육청", "울산광역시교육청", "세종특별자치시교육청", "경기도교육청", "강원도교육청", "충청북도교육청", "충청남도교육청", "전라북도교육청", "전라남도교육청", "경상북도교육청", "경상남도교육청", "제주특별자치도교육청" ]
        edudropDown.anchorView = eduButton
        edudropDown.bottomOffset = CGPoint(x: 0, y: (edudropDown.anchorView?.plainView.bounds.height)!)
        /*
        leveldropDown.dataSource = ["전체", "고등학교","중학교", "초등학교", "특수학교" ]
        leveldropDown.anchorView = schoollevelButton
        leveldropDown.bottomOffset = CGPoint(x: 0, y: (leveldropDown.anchorView?.plainView.bounds.height)!)
        */
        schoolTableView.delegate = self
        schoolTableView.dataSource = self
    }
    
    func beginParsing()
    {
        let eduurl = eduDic[eduButton.currentTitle!]
        /*
        var levelurl = schoollevelButton.currentTitle ?? "전체"
        if levelurl == "전체" {
            levelurl = ""
        } else {
            levelurl = "&SCHUL_KND_SC_NM="+levelurl.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        }
 */
        var searchurl = searchText.text ?? ""
        if searchurl != "" {
            searchurl = "&ACA_NM=" + searchurl.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        }
        posts = []
        parser = XMLParser(contentsOf: (URL(string: "https://open.neis.go.kr/hub/acaInsTiInfo?KEY=92f8da4aa880435a8d6241dc3d456fb2&Type=xml&pIndex=1&pSize=100&ATPT_OFCDC_SC_CODE="+eduurl!+searchurl)!))!
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
            acatotal = NSMutableString()
            state = NSMutableString()
            addr = NSMutableString()
            subjectkind = NSMutableString()
            subjectlist = NSMutableString()
            subject = NSMutableString()
            fare = NSMutableString()
            kind = NSMutableString()
            estdate = NSMutableString()
            
            title1 = ""
            locationName = ""
            edu = ""
            code = ""
            engTitle = ""
            acatotal = ""
            state = ""
            addr = ""
            subjectkind = ""
            subjectlist = ""
            subject = ""
            fare = ""
            kind = ""
            estdate = ""
            
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if element.isEqual(to: "ACA_NM") { // 학원명
            title1.append(string)
        } else if element.isEqual(to: "ADMST_ZONE_NM") { // 행정구역
            locationName.append(string)
        }
        else if element.isEqual(to: "ATPT_OFCDC_SC_NM") { //교육청
            edu.append(string)
        }
        else if element.isEqual(to: "ACA_ASNUM") { //학원코드
            code.append(string)
        }
        else if element.isEqual(to: "ACA_INSTI_SC_NM") { //교습소 명
            engTitle.append(string)
        }
        else if element.isEqual(to: "TOFOR_SMTOT") { //정원 합계
            acatotal.append(string)
        }
        else if element.isEqual(to: "REG_STTUS_NM") { // 등록 상태명
            state.append(string)
        }
        else if element.isEqual(to: "FA_RDNMA") { // 도로명 주소
            addr.append(string)
        }
        else if element.isEqual(to: "REALM_SC_NM") { // 분야명
            kind.append(string)
        }
        else if element.isEqual(to: "LE_ORD_NM") { // 교습계열명
            subjectkind.append(string)
        }
        else if element.isEqual(to: "LE_CRSE_LIST_NM") { // 교습과정목록명
            subjectlist.append(string)
        }
        else if element.isEqual(to: "LE_CRSE_NM") { // 교습과정명
            subject.append(string)
        }
        else if element.isEqual(to: "PSNBY_THCC_CNTNT") { //수강료
            fare.append(string)
        }
        else if element.isEqual(to: "ESTBL_YMD") { // 개설일
            estdate.append(string)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if (elementName as NSString).isEqual(to: "row"){
            if !title1.isEqual(nil){
                elements.setObject(title1, forKey: "ACA_NM" as NSCopying)
            }
            if !locationName.isEqual(nil){
                elements.setObject(locationName, forKey: "ADMST_ZONE_NM" as NSCopying)
            }
            if !edu.isEqual(nil){
                elements.setObject(edu, forKey: "ATPT_OFCDC_SC_NM" as NSCopying)
            }
            if !code.isEqual(nil){
                elements.setObject(code, forKey: "ACA_ASNUM" as NSCopying)
            }
            if !engTitle.isEqual(nil){
                elements.setObject(engTitle, forKey: "ACA_INSTI_SC_NM" as NSCopying)
            }
            if !acatotal.isEqual(nil){
                elements.setObject(acatotal, forKey: "TOFOR_SMTOT" as NSCopying)
            }
            if !state.isEqual(nil){
                elements.setObject(state, forKey: "REG_STTUS_NM" as NSCopying)
            }
            if !addr.isEqual(nil){
                elements.setObject(addr, forKey: "FA_RDNMA" as NSCopying)
            }
            if !subjectkind.isEqual(nil){
                elements.setObject(subjectkind, forKey: "LE_ORD_NM" as NSCopying)
            }
            if !subjectlist.isEqual(nil){
                elements.setObject(subjectlist, forKey: "LE_CRSE_LIST_NM" as NSCopying)
            }
            if !subject.isEqual(nil){
                elements.setObject(subject, forKey: "LE_CRSE_NM" as NSCopying)
            }
            if !fare.isEqual(nil){
                elements.setObject(fare, forKey: "PSNBY_THCC_CNTNT" as NSCopying)
            }
            if !estdate.isEqual(nil){
                elements.setObject(estdate, forKey: "ESTBL_YMD" as NSCopying)
            }
            if !kind.isEqual(nil){
                elements.setObject(kind, forKey: "REALM_SC_NM" as NSCopying)
            }
            posts.add(elements)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AcademyCell", for: indexPath)
        
        cell.textLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "ACA_NM") as! NSString as String
        cell.detailTextLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "FA_RDNMA") as! NSString as String
        return cell
    }

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let tcode = (posts.object(at: (indexPath.row)) as AnyObject).value(forKey: "ACA_ASNUM") as! NSString as String
        
        let actions1 = UIContextualAction(style: .normal, title: "1") { [self] (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            if(Favorite.SharedInstance().isContainCode(code: tcode)) {
                Favorite.SharedInstance().delFavCode(code: tcode)
            } else {
                let actitle = (posts.object(at: (indexPath.row)) as AnyObject).value(forKey: "ACA_NM") as! NSString as String
                let aclocationName = (posts.object(at: (indexPath.row)) as AnyObject).value(forKey: "ADMST_ZONE_NM") as! NSString as String
                let acedu = (posts.object(at: (indexPath.row)) as AnyObject).value(forKey: "ATPT_OFCDC_SC_NM") as! NSString as String
                let accode = (posts.object(at: (indexPath.row)) as AnyObject).value(forKey: "ACA_ASNUM") as! NSString as String
                let acengTitle = (posts.object(at: (indexPath.row)) as AnyObject).value(forKey: "ACA_INSTI_SC_NM") as! NSString as String
                let actotal = (posts.object(at: (indexPath.row)) as AnyObject).value(forKey: "TOFOR_SMTOT") as! NSString as String
                let acstate = (posts.object(at: (indexPath.row)) as AnyObject).value(forKey: "REG_STTUS_NM") as! NSString as String
                let acaddr = (posts.object(at: (indexPath.row)) as AnyObject).value(forKey: "FA_RDNMA") as! NSString as String
                let acsubjectkind = (posts.object(at: (indexPath.row)) as AnyObject).value(forKey: "LE_ORD_NM") as! NSString as String
                let acsubjectlist = (posts.object(at: (indexPath.row)) as AnyObject).value(forKey: "LE_CRSE_LIST_NM") as! NSString as String
                let acsubject = (posts.object(at: (indexPath.row)) as AnyObject).value(forKey: "LE_CRSE_NM") as! NSString as String
                let acfare = (posts.object(at: (indexPath.row)) as AnyObject).value(forKey: "PSNBY_THCC_CNTNT") as! NSString as String
                let ackind = (posts.object(at: (indexPath.row)) as AnyObject).value(forKey: "REALM_SC_NM") as! NSString as String
                let acestdate = (posts.object(at: (indexPath.row)) as AnyObject).value(forKey: "ESTBL_YMD") as! NSString as String
                
                let academyData = CAcademy(edu: acedu, code: accode, title: actitle, engTitle: acengTitle, acatotal: actotal, locationName: aclocationName, state: acstate, addr: acaddr, subjectkind: acsubjectkind, subjectlist: acsubjectlist, subject: acsubject, fare: acfare, kind: ackind, estdate: acestdate)
                Favorite.SharedInstance().addFav(academy: academyData)
            }
            success(true)
        }
        
        if(Favorite.SharedInstance().isContainCode(code: tcode)) {
            actions1.image = UIImage(named: "favorite_icon2")
        } else {
            actions1.image = UIImage(named: "favorite_icon")
        }
        
        return UISwipeActionsConfiguration(actions: [actions1])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToAcademyInfo" {
            if let rvc = segue.destination as? AcademyInfoViewController {
                if let sgCell = sender as? UITableViewCell {
                    let indexPath = schoolTableView.indexPath(for: sgCell)
                    let actitle = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "ACA_NM") as! NSString as String
                    let aclocationName = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "ADMST_ZONE_NM") as! NSString as String
                    let acedu = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "ATPT_OFCDC_SC_NM") as! NSString as String
                    let accode = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "ACA_ASNUM") as! NSString as String
                    let acengTitle = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "ACA_INSTI_SC_NM") as! NSString as String
                    let actotal = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "TOFOR_SMTOT") as! NSString as String
                    let acstate = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "REG_STTUS_NM") as! NSString as String
                    let acaddr = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "FA_RDNMA") as! NSString as String
                    let acsubjectkind = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "LE_ORD_NM") as! NSString as String
                    let acsubjectlist = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "LE_CRSE_LIST_NM") as! NSString as String
                    let acsubject = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "LE_CRSE_NM") as! NSString as String
                    let acfare = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "PSNBY_THCC_CNTNT") as! NSString as String
                    let ackind = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "REALM_SC_NM") as! NSString as String
                    let acestdate = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "ESTBL_YMD") as! NSString as String
                    
                    rvc.academyData = CAcademy(edu: acedu, code: accode, title: actitle, engTitle: acengTitle, acatotal: actotal, locationName: aclocationName, state: acstate, addr: acaddr, subjectkind: acsubjectkind, subjectlist: acsubjectlist, subject: acsubject, fare: acfare, kind: ackind, estdate: acestdate)
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
