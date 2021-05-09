//
//  SchoolInfoViewController.swift
//  TermProjcet
//
//  Created by kpugame on 2021/05/09.
//

import UIKit
import MapKit
import MaterialComponents.MaterialBottomSheet

class SchoolInfoViewController: UIViewController, XMLParserDelegate, MKMapViewDelegate {

    var parser = XMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    
    var title1 = NSMutableString()
    var addr = NSMutableString()
    
    var XPos = NSMutableString()
    var YPos = NSMutableString()
    
    var schoolData = CSchool(edu: "", code: "", title: "", engTitle: "", level: "", locationName: "", pbpr: "", addr: "", tel: "", site: "", jender: "", fax: "", kind: "", estdate: "", holiday: "", educode: "")
    var url = ""
    
    let regionRadius: CLLocationDistance = 500
    var schoolinfo : [CSchoolMap] = []
    @IBOutlet weak var sNameText: UILabel!
    @IBOutlet weak var sEduText: UILabel!
    @IBOutlet weak var sPbprText: UILabel!
    @IBOutlet weak var sAddrText: UILabel!
    @IBOutlet weak var sTelText: UILabel!
    @IBOutlet weak var sSiteText: UILabel!
    @IBOutlet weak var sJenderText: UILabel!
    @IBOutlet weak var sFaxText: UILabel!
    @IBOutlet weak var sKindText: UILabel!
    @IBOutlet weak var sEstdateText: UILabel!
    @IBOutlet weak var sHolidayText: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!

    @IBOutlet weak var calendarButton: UIButton!
    
    @IBAction func openCalendar(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CalendarViewController") as! ViewController
        let bottomSheet: MDCBottomSheetController = MDCBottomSheetController(contentViewController: vc)
        vc.code = schoolData.code
        vc.edu = schoolData.educode
        present(bottomSheet, animated: true, completion: nil)
    }
    
    func makeDate(str: String) -> String {
        var str2 = str
        str2.insert("-", at: str2.index(str2.startIndex, offsetBy: 4))
        str2.insert("-", at: str2.index(str2.startIndex, offsetBy: 7))
        return str2
    }
    func loadInitialData(){
        for post in posts {
            let yadmNm = schoolData.title
            let addr = schoolData.addr
            let XPos = (post as AnyObject).value(forKey: "EPSG_4326_X") as! NSString as String
            let YPos = (post as AnyObject).value(forKey: "EPSG_4326_Y") as! NSString as String
            let lat = (YPos as NSString).doubleValue
            let lon = (XPos as NSString).doubleValue
            let school = CSchoolMap(title: yadmNm, locationName: addr, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon))
            schoolinfo.append(school)
        }
    }
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! CSchoolMap
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? CSchoolMap else { return nil }
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView{
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        beginParsing()
        sNameText.text = schoolData.title as String
        sEduText.text = schoolData.edu as String
        sPbprText.text = schoolData.pbpr as String
        sAddrText.text = schoolData.addr as String
        sTelText.text = schoolData.tel as String
        sSiteText.text = schoolData.site as String
        sJenderText.text = schoolData.jender as String
        sFaxText.text = schoolData.fax as String
        sKindText.text = schoolData.kind as String
        sEstdateText.text = makeDate(str: schoolData.estdate as String)
        sHolidayText.text = makeDate(str: schoolData.holiday as String)
        
        var lat = 0.0
        var lon = 0.0
        for post in posts {
            let XPos = (post as AnyObject).value(forKey: "EPSG_4326_X") as! NSString as String
            let YPos = (post as AnyObject).value(forKey: "EPSG_4326_Y") as! NSString as String
            lat = (YPos as NSString).doubleValue
            lon = (XPos as NSString).doubleValue
        }
        let initialLocation = CLLocation(latitude: lat, longitude: lon)
        centerMapOnLocation(location: initialLocation)
        // Do any additional setup after loading the view.
        mapView.delegate = self
        loadInitialData()
        mapView.addAnnotations(schoolinfo)
    }
    
    func beginParsing()
    {
        posts = []
        let addrutf = schoolData.addr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        url = "http://apis.vworld.kr/new2coord.do?output=xml&apiKey=76DFEBC9-7635-304E-AE19-9DFEF30F1976&q=" + addrutf!
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
            addr = NSMutableString()
            addr = ""
            
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if element.isEqual(to: "EPSG_4326_X") {
            title1.append(string)
        } else if element.isEqual(to: "EPSG_4326_Y") {
            addr.append(string)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if (elementName as NSString).isEqual(to: "result"){
            if !title1.isEqual(nil){
                elements.setObject(title1, forKey: "EPSG_4326_X" as NSCopying)
            }
            if !addr.isEqual(nil){
                elements.setObject(addr, forKey: "EPSG_4326_Y" as NSCopying)
            }
            
            posts.add(elements)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToSchoolWebView" {
            if let schoolwebView = segue.destination as? SchoolWebViewController {
                schoolwebView.urltext = schoolData.site
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
