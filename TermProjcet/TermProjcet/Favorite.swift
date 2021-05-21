class Favorite{
    
    public var favlist: [CAcademy] = []
    
    struct StaticInstance {
        static var instance: Favorite?
    }
    
    class func SharedInstance() -> Favorite{
        if(StaticInstance.instance == nil){
            StaticInstance.instance = Favorite()
        }
        return StaticInstance.instance!
    }
    
    
    func addFav(academy: CAcademy) {
        favlist.append(academy)
    }
    
    func delFav(academy: CAcademy) {
        
        for i in favlist {
            if i.code == academy.code {
                let findex = favlist.firstIndex(of: i)
                favlist.remove(at: findex!)
            }
        }
    }
    
    func delFavCode(code: String) {
        
        for i in favlist {
            if i.code == code {
                let findex = favlist.firstIndex(of: i)
                favlist.remove(at: findex!)
            }
        }
    }
    
    func isContain(academy: CAcademy) -> Bool {
        
        for i in favlist {
            if i.code == academy.code {
                return true
            }
        }
        return false
    }
    
    func isContainCode(code: String) -> Bool {
        
        for i in favlist {
            if i.code == code {
                return true
            }
        }
        return false
    }
    
    /*
    func isContain(academy: CAcademy) -> Bool {
        return favlist.contains(academy)
    }*/
}
