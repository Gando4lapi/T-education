import UIKit

//1
print("")
print("#1")
print("")

let string10 = "apple Orange pineapple PEAR"

var result0 = string10.split(separator: " ")
var newArray = [String]()
for i in result0{
    let word = String(i).lowercased()
    if !newArray.contains(word){
        newArray.append(word)
    }
}

let col0 = newArray.count
print(col0)

let string20 = "apple aPPle appLe Apple"

var result20 = string20.split(separator: " ")
var newArray2 = [String]()
for i in result20{
    let word2 = String(i).lowercased()
    if !newArray2.contains(word2){
        newArray2.append(word2)
    }
}

let col20 = newArray2.count
print(col20)

print("")
print("#2")
print("")

//2

let string1 = "(())"
let string2 = "))(("
let string3 = "()()()"

let lenstr1 = string1.count
let lenstr2 = string2.count
let lenstr3 = string3.count


var c1 = 0

if lenstr1 % 2 != 0 {
    print("Некорректная")
} else {
    var val1 = true
    for i in 0..<(lenstr1 / 2)-1 {
        let openChar1 = string1[string1.index(string1.startIndex, offsetBy: i)]
        let closingChar1 = string1[string1.index(string1.startIndex, offsetBy: (lenstr1 - 1 - i))]
        let firststr1 = string1[string1.startIndex]
        let laststr1 = string1[string1.index(before: string1.endIndex)]
        
        if ((openChar1 == "(" && closingChar1 == ")") || (openChar1 == ")" && closingChar1 == "(") && (firststr1 == "(" && laststr1 == ")")) {
            val1 = true
        } else{
            val1 = false
            break
        }
    }
    
    if val1 {
        print("Корректная")
    } else {
        print("Некорректная")
    }
}



var c2 = 0

if lenstr2 % 2 != 0 {
    print("Некорректная")
} else {
    var val2 = true
    for i in 0..<(lenstr2 / 2)-1 {
        let openChar2 = string2[string2.index(string2.startIndex, offsetBy: i)]
        let closingChar2 = string2[string2.index(string2.startIndex, offsetBy: (lenstr2 - 1 - i))]
        let firststr2 = string2[string2.startIndex]
        let laststr2 = string2[string2.index(before: string2.endIndex)]
        
        if ((openChar2 == "(" && closingChar2 == ")") || (openChar2 == ")" && closingChar2 == "(") && (firststr2 == "(" && laststr2 == ")")) {
            val2 = true
        } else{
            val2 = false
            break
        }
    }
    
    if val2 {
        print("Корректная")
    } else {
        print("Некорректная")
    }
}



var c3 = 0

if lenstr3 % 2 != 0 {
    print("Некорректная")
} else {
    var val3 = true
    for i in 0..<(lenstr3 / 2)-1 {
        let openChar3 = string3[string3.index(string3.startIndex, offsetBy: i)]
        let closingChar3 = string3[string3.index(string3.startIndex, offsetBy: (lenstr3 - 1 - i))]
        let firststr3 = string3[string3.startIndex]
        let laststr3 = string3[string3.index(before: string3.endIndex)]
        
        if ((openChar3 == "(" && closingChar3 == ")") || (openChar3 == ")" && closingChar3 == "(") && (firststr3 == "(" && laststr3 == ")")) {
            val3 = true
        } else{
            val3 = false
            break
        }
    }
    
    if val3 {
        print("Корректная")
    } else {
        print("Некорректная")
    }
}


print("")
print("#3")
print("")

//3

let array1 = ["a", "bb", "b", "cccc"]
let array2 = ["a", "b", "c"]

var newArr1 = [String]()
var newArr2 = [String]()
var maxArr1 = 0
var maxArr2 = 0
for i in array1{
    var count1 = i.count
    if count1 > maxArr1{
        maxArr1 = count1
    }
}

for i in array2{
    var count2 = i.count
    if count2 > maxArr2{
        maxArr2 = count2
    }
}

for value1 in 1...maxArr1{
    newArr1 = [String]()
    for i in array1{
        var count1 = i.count
        if count1 == value1{
            newArr1.append(i)
        }
    }
    var lens1 = newArr1.count
    if lens1 > 0{
        print("\(value1) - \(newArr1)")
    }
}

print()

for value2 in 1...maxArr2{
    newArr2 = [String]()
    for i in array2{
        var count2 = i.count
        if count2 == value2{
            newArr2.append(i)
        }
    }
    var lens2 = newArr2.count
    if lens2 > 0{
        print("\(value2) - \(newArr2)")
    }
}


print("")
print("#4")
print("")

//4

let dict1 = ["A": 4, "B": 4, "C": 4]
let dict2 = ["A": nil, "B": nil, "C": nil] as [String : Any?]


var col1 = 0
var sumvals1 = 0
for (_, value1) in dict1 {
    if value1 != 0 {
        col1 += 1
        sumvals1 += value1
    }
}

if col1 == 0{
    print("Никто не сдал!")
} else{
    print(sumvals1/col1)
}

var col2 = 0
var sumvals2 = 0

for (_, value2) in dict2{
    if value2 != nil{
        col2 += 1
        sumvals2 += value2 as! Int
    }
}

if col2 == 0{
    print("Никто не сдал!")
} else{
    print(sumvals2/col2)
}

//5

print("")
print("#5")
print("")

func summa(num1 : Int, num2 : Int) -> String {
    let summi = num1 + num2
    var strsummi = "Сумма чисел \(num1) и \(num2) = \(summi)"
    return strsummi
}

func square(num: Int) -> String {
    let numS = num * num
    var strsquare = "Квадрат числа \(num) = \(numS)"
    return strsquare
}

func proiz(num1 : Int, num2 : Int) -> String {
    let p = num1 * num2
    var strproiz = "Произведение чисел \(num1) и \(num2) = \(p)"
    return strproiz
}

func sqr(num : Float) -> String {
    let koren = num * 0.5
    var strsquare = "Корень числа \(num) = \(koren)"
    return strsquare
}

func summakv(num1 : Int, num2 : Int) -> String {
    let summakv = num1*num1 + num2*num2
    var strsumkv = "Cумма квадратов чисел \(num1) и \(num2) = \(summakv)"
    return strsumkv
}

var array = [summa(num1: 1, num2: 2), square(num: 4), proiz(num1: 3, num2: 4), sqr(num: 16), summakv(num1: 5, num2: 7)]

for i in array{
    print(i)
}
