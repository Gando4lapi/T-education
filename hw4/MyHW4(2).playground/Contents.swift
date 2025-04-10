import UIKit

class Animal {
    func speak(){}
}

class Dog: Animal {
    override func speak() {
        print("Woof!")
    }
}

class Cat: Animal {
    override func speak() {
        print("Meow!")
    }
}

var animals : [Animal] = [Cat(), Dog(), Dog(), Cat()]

for animal in animals {
    animal.speak()
}
