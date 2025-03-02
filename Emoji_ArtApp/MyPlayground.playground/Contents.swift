import UIKit

var greeting = "Hello, playground"
print(greeting)

enum MyEnum {
    case tab(Int)
    case lineFeed(String)
    case carriage
}

var a: MyEnum = .tab(12)
a = .tab(13)
print(a)


