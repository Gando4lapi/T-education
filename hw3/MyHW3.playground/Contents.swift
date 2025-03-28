import Foundation

class GameCharacter {
    let name: String
    var health: Int
    var level: Int
    let healthMax: Int

    init(name: String, health: Int, level: Int) {
        self.name = name
        self.health = health
        self.level = level
        self.healthMax = health
    }

    func takeDamage(by amount: Int) {
        health -= amount
        if health < 0 {
            health = 0
        }
    }

    func heal(by amount: Int) {
        health += amount
        print("\(name) заюзал аптечку на \(amount) единиц здоровья")
        if health > healthMax {
            health = healthMax
        }
    }

    func levelUp() {
        level += 1
    }

    func attack(target: GameCharacter) {
        let damage = 10
        target.takeDamage(by: damage)
        print("\(name) нанес урон \(target.name) на \(damage)!")
    }
}

var player = GameCharacter(name: "Danil", health: 100, level: 1)

class Warrior: GameCharacter {
    var strength: Int

    init(name: String, health: Int, level: Int, strength: Int) {
        self.strength = strength
        super.init(name: name, health: health, level: level)
    }

    func warriorAttack(target: GameCharacter) {
        let damage = 5 * strength
        target.takeDamage(by: damage)
        print("Воин \(name) наносит урон воину \(target.name) на \(damage)!")
    }

    func warriorHeal(){
        health += 5 * level
        if health > 100{
            health = 100
        }
    }
}

class Assasin: GameCharacter {
    var agility: Int

    init(name: String, health: Int, level: Int, agility: Int) {
        self.agility = agility
        super.init(name: name, health: health, level: level)
    }

    func assasinAttack(target: GameCharacter) {
        let damage = 3 * agility
        target.takeDamage(by: damage)
        print("Ассасин \(name) использует кинжал и наносит \(damage) урона \(target.name)!")
    }

    func assasinHeal(){
        health += 5 * level
        if health > 100{
            health = 100
        }
    }
}

protocol Flyable {
    var flightSpeed: Int { get }
    func fly()
}

extension Warrior: Flyable {
    var flightSpeed: Int {
        return 10 * level
    }

    func fly() {
        print("\(name) взлетел! И летит со скоростью \(flightSpeed)!")
    }
}

extension Assasin: Flyable {
    var flightSpeed: Int {
        return 5 * level
    }

    func fly() {
        print("\(name) взлетел! И летит со скоростью \(flightSpeed)!")
    }
}

extension GameCharacter {
    var isAlive: Bool {
        return health > 0
    }

    func printCharacterInfo() {
        print("Name: \(name), Health: \(health), Level: \(level), Alive: \(isAlive)")
    }
}

let warrior = Warrior(name: "Conan", health: 50, level: 1, strength: 2)
let assasin = Assasin(name: "Gandalf", health: 30, level: 1, agility: 3)

warrior.printCharacterInfo()
assasin.printCharacterInfo()

warrior.warriorAttack(target: player)
assasin.assasinAttack(target: player)

player.printCharacterInfo()

player.heal(by: 20)

player.printCharacterInfo()
player.attack(target: warrior)
player.attack(target: assasin)
warrior.printCharacterInfo()
assasin.printCharacterInfo()

warrior.levelUp()
assasin.levelUp()

warrior.printCharacterInfo()
assasin.printCharacterInfo()
