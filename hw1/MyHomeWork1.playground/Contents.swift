import UIKit

func number(num : Int) {
    print("")
    print("#\(num)")
    print("")
}

number(num:1) //1

func numberOne(frase : String) {
    var result = frase.split(separator: " ")
    var emptyArray = [String]()
    for i in result{
        let word = String(i).lowercased()
        if !emptyArray.contains(word){
            emptyArray.append(word)
        }
    }

    let lotUnicWord = emptyArray.count
    print(lotUnicWord)
}
let string10 = "apple Orange pineapple PEAR"
let string20 = "apple aPPle appLe Apple"

numberOne(frase : string10)
numberOne(frase : string20)

number(num: 2) //2

func numberTwo(string : String) {
    let lenstr = string.count
    if lenstr % 2 != 0 {
        print("Некорректная")
    } else {
        var identifier = true
        for i in 0..<(lenstr / 2)-1 {
            let openChar = string[string.index(string.startIndex, offsetBy: i)]
            let closingChar = string[string.index(string.startIndex, offsetBy: (lenstr - 1 - i))]
            let firststr = string[string.startIndex]
            let laststr = string[string.index(before: string.endIndex)]
            
            if ((openChar == "(" && closingChar == ")") || (openChar == ")" && closingChar == "(") && (firststr == "(" && laststr == ")")) {
                identifier = true
            } else{
                identifier = false
                break
            }
        }
        
        if identifier {
            print("Корректная")
        } else {
            print("Некорректная")
        }
    }
}

let string1 = "(())"
let string2 = "))(("
let string3 = "()()()"

numberTwo(string: string1)
numberTwo(string: string2)
numberTwo(string: string3)

number(num: 3) //3

func numberThree(array : [String]) {
    var emptyArray = [String]()
    var maxLenArray = 0
    for element in array{
        var countOfElem = element.count
        if countOfElem > maxLenArray{
            maxLenArray = countOfElem
        }
    }
    for value in 1...maxLenArray{
        emptyArray = [String]()
        for element in array{
            var count = element.count
            if count == value{
                emptyArray.append(element)
            }
        }
        var lenOfArray = emptyArray.count
        if lenOfArray > 0{
            print("\(value) - \(emptyArray)")
        }
    }
    print()
}

let array1 = ["a", "bb", "b", "cccc"]
let array2 = ["a", "b", "c"]

numberThree(array: array1)
numberThree(array: array2)

number(num: 4) //4

func middleGrade(from dict: [String: Int?]) {
    let grades = dict.compactMap { $0.value }
    if grades.isEmpty {
        print("Никто не сдал")
    } else {
        let average = grades.reduce(0, +) / grades.count
        print(average)
    }
}
let dict1: [String: Int?] = ["A": 4, "B": 4, "C": 4]
middleGrade(from: dict1)
let dict2: [String: Int?] = ["A": nil, "B": nil, "C": nil]
middleGrade(from: dict2)

number(num: 5) //5

enum mathematicalOperations {
    case summa(Double, Double)
    case subtract(Double, Double)
    case multiply(Double, Double)
    case divide(Double, Double)
    case square(Double)
    case sqrt(Double)
}

func transferOperations(_ operations: [mathematicalOperations]) {
    for operation in operations {
        switch operation {
        case .summa(let a, let b):
            print("Сумма чисел \(a) и \(b) - \(a + b)")
        case .subtract(let a, let b):
            print("Разность чисел \(a) и \(b) - \(a - b)")
        case .multiply(let a, let b):
            print("Умножение чисел \(a) и \(b) - \(a * b)")
        case .divide(let a, let b):
            if b != 0 {
                print("Деление чисел \(a) и \(b) - \(a / b)")
            } else {
                print("Деление на число \(b) = 0 невозможно!")
            }
        case .square(let a):
            print("Квадрат числа \(a) - \(a * a)")
        case .sqrt(let a):
            if a >= 0 {
                print("Квадратный корень - \(sqrt(a))")
            } else {
                print("Квадратный корень из отрицательного числа невозможен")
            }
        }
    }
}

let array5: [mathematicalOperations] = [.summa(1, 2), .square(2), .sqrt(9), .divide(10, 2), .subtract(5, 3)]
transferOperations(array5)
