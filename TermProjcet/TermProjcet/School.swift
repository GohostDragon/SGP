//
//  School.swift
//  TermProjcet
//
//  Created by kpugame on 2021/05/09.
//

import Foundation

import MapKit
import Contacts

class CSchool: NSObject {
    let edu: String
    let code: String
    let title: String
    let engTitle: String
    let level: String
    let locationName: String
    let pbpr: String
    let addr: String
    let tel: String
    let site: String
    let jender: String
    let fax: String
    let kind: String
    let estdate: String
    let holiday: String
    
    init(edu: String, code: String, title: String, engTitle: String, level: String, locationName: String, pbpr: String, addr: String, tel: String, site: String, jender: String, fax: String, kind: String, estdate: String, holiday: String) {
        self.title = title
        self.locationName = locationName
        self.edu = edu
        self.code = code
        self.engTitle = engTitle
        self.level = level
        self.pbpr = pbpr
        self.addr = addr
        self.tel = tel
        self.site = site
        self.jender = jender
        self.fax = fax
        self.kind = kind
        self.estdate = estdate
        self.holiday = holiday
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
    
    func printSchool() {
        print(self.title)
        print(self.locationName)
        print(self.edu)
        print(self.code)
        print(self.engTitle)
        print(self.level)
        print(self.pbpr)
        print(self.addr)
        print(self.tel)
        print(self.site)
        print(self.jender)
        print(self.fax)
        print(self.kind)
        print(self.estdate)
        print(self.holiday)
    }
}
