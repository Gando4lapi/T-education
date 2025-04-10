import UIKit

class Person {
    let name : String
    var car : Car?
    
    init(name : String, car : Car?){
        self.name = name
        self.car = car
        print("\(name) инициализирован!")
    }
    
    deinit {
        print("\(name) деинициализирован!")
    }
}

class Car {
    let type : String
    var owner : Person?
    
    init(type : String, owner : Person?){
        self.type = type
        self.owner = owner
        print("\(type) инициализирован!")
    }
    
    deinit {
        print("\(type) деинициализирован!")
    }
}

class Person2 {
    let name : String
    var car : Car2?
    
    init(name : String, car : Car2?){
        self.name = name
        self.car = car
        print("Исправленный \(name) инициализирован!")
    }
    
    deinit {
        print("Исправленный \(name) деинициализирован!")
    }
}

class Car2 {
    let type : String
    weak var owner : Person2?
    
    init(type : String, owner : Person2?){
        self.type = type
        self.owner = owner
        print("Исправленный \(type) инициализирован!")
    }
    
    deinit {
        print("Исправленный \(type) деинициализирован!")
    }
}

func demoError(){
    print("Демонстрация работы проблемы циклических ссылок")
    var danil : Person? = Person(name : "Danil", car : nil)
    var lada : Car? = Car(type : "Niva", owner : nil)
    
    danil?.car = lada
    lada?.owner = danil
    
    danil = nil
    lada = nil
//пояснение для ментора: из-за сильных ссылок, объекты в памяти ссылаются друг на друга в памяти, тем самым заменяя друг друга, поэтому деинициализация не происходит
}

func demoFix(){
    print("Демонстрация решения проблемы циклических ссылок")
    var egor : Person2? = Person2(name: "Egor", car: nil)
    var bmw : Car2? = Car2(type: "m4", owner: nil)
    
    egor?.car = bmw
    bmw?.owner = egor
    
    egor = nil
    bmw = nil

//тут все исправленно благодаря так называемой "слабой ссылке"
}
demoError()
demoFix()
