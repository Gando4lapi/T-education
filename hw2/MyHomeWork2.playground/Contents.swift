import UIKit

enum Genre: String, CaseIterable {
    case fiction = "Фантастика"
    case mystery = "Детектив"
    case romance = "Роман"
    case poems = "Поэмы"
    case novel = "Новелла"
}

struct Book {
    let title: String
    let author: String
    let price: Double
    let genre: Genre
}

class Library {
    private var books: [Book] = []
    
    func addBook(_ book: Book) {
        books.append(book)
    }
    
    func filterByGenre(_ genre: Genre) -> [Book] {
        return books.filter { $0.genre == genre }
    }
    
    func filterByTitle(_ title: String) -> [Book] {
        return books.filter { $0.title.lowercased().contains(title.lowercased()) }
    }
    
    func filterBook(by genre: Genre? = nil, byName title: String? = nil) -> [Book] {
        return books.filter { book in
            let matchesGenre = genre == nil || book.genre == genre
            let matchesTitle = title == nil || book.title.lowercased().contains(title?.lowercased() ?? "")
            return matchesGenre && matchesTitle
        }
    }
}

class User {
    let name: String
    let discount: Double
    private var cart: [Book] = []
    
    init(name: String, discount: Double) {
        self.name = name
        self.discount = discount
    }
    
    func addBookToCart(_ book: Book) {
        cart.append(book)
    }
    
    func addToCart(_ books: [Book]) {
        cart.append(contentsOf: books)
    }
    
    func totalPrice() -> String {
        let total = cart.reduce(0) { $0 + $1.price }
        return String(format: "%.2f руб.", total * (100 - discount) * 0.01)
    }
    
    func sortedListOfBooks(by sorter: (Book, Book) -> Bool) -> [Book] {
        return cart.sorted(by: sorter)
    }
   
}

let library = Library()
library.addBook(
    Book(
        title: "Гарри Поттер и философский камень",
        author: "Дж.К. Роулинг",
        price: 1000,
        genre: .fiction
    )
)
library.addBook(
    Book(
        title: "Война и мир",
        author: "Лев Толстой",
        price: 850,
        genre: .novel
    )
)
library.addBook(
    Book(
        title: "Стихотворение",
        author: "Владимир Маяковский",
        price: 540,
        genre: .poems
    )
)

let user = User(name: "Алиса", discount: 1.5)
let novelBooks = library.filterBook(by: .novel)
user.addToCart(novelBooks)
let booksWithName = library.filterBook(byName: "Гарри")
user.addToCart(booksWithName)

print("Итоговая корзина: \(user.sortedListOfBooks(by: { $0.title < $1.title }))")
print("Цена корзины: \(user.totalPrice())")
