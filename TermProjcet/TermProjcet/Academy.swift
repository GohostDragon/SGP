//
//  School.swift
//  TermProjcet
//
//  Created by kpugame on 2021/05/09.
//

import Foundation

import MapKit
import Contacts

class CAcademy: NSObject {
    let edu: String
    let code: String
    let title: String
    let engTitle: String
    let acatotal: String
    let locationName: String
    let state: String
    let addr: String
    let subjectkind: String
    let subjectlist: String
    let subject: String
    let fare: String
    let kind: String
    let estdate: String
    
    init(edu: String, code: String, title: String, engTitle: String, acatotal: String, locationName: String, state: String, addr: String, subjectkind: String, subjectlist: String, subject: String, fare: String, kind: String, estdate: String) {
        self.title = title
        self.locationName = locationName
        self.edu = edu
        self.code = code
        self.engTitle = engTitle
        self.acatotal = acatotal
        self.state = state
        self.addr = addr
        self.subjectkind = subjectkind
        self.subjectlist = subjectlist
        self.subject = subject
        self.fare = fare
        self.kind = kind
        self.estdate = estdate
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
        print(self.acatotal)
        print(self.state)
        print(self.addr)
        print(self.subjectkind)
        print(self.subjectlist)
        print(self.subject)
        print(self.fare)
        print(self.kind)
        print(self.estdate)
    }
}
