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
        let findex = favlist.firstIndex(of: academy)
        favlist.remove(at: findex!)
    }
    
    func isContain(academy: CAcademy) -> Bool {
        return favlist.contains(academy)
    }
}
