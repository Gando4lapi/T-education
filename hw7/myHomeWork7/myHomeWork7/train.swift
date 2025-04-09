//
//  train.swift
//  myHomeWork7
//
//  Created by main on 09.04.2025.
//

protocol Item {
    associatedtype Item
    var title: String { get }
    var company: String { get }
    var prise: String { get }
    func next() -> Item
}

enum Train: Int, Item {
    
    enum TrainCompany: String {
        case rgd = "Russian railways"
        case sm = "Siemens Mobility"
    }
    
    case lastochka = 0, sapsan, ivolga, redArrow, metro
    
    var title: String {
        switch self {
        case .lastochka:
            "Lastochka"
        case .sapsan:
            "Sapsan"
        case .ivolga:
            "Ivolga"
        case .redArrow:
            "Krasnaya Strela"
        case .metro:
            "Poezd Metro"
        }
    }
    
    var company: String {
        switch self {
        case .lastochka, .sapsan:
            "Siemens Mobility"
        case .ivolga, .redArrow, .metro:
            "Russian railways"
        }
    }
    
    var intPrise: Int {
        switch self {
        case .sapsan:
            8000000
        case .lastochka, .redArrow:
            4000000
        case .metro:
            5000000
        case .ivolga:
            3000000
        }
    }
    
    var prise: String {
        var prise = intPrise
        var count = 0
        var strPrise = ""
        while prise != 0 {
            strPrise = String(prise % 10) + strPrise
            count += 1
            if count == 3 && !(1...9).contains(prise) {
                strPrise = " " + strPrise
                count = 0
            }
            prise /= 10
        }
        return strPrise + " USDT"
    }
    
    func next() -> Train {
        Train(rawValue: (rawValue + 1) % 5) ?? .lastochka
    }
}


