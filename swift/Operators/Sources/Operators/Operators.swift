import Foundation

@main
public struct Operators {
    public private(set) var text = "Hello, World!"

    public static func main() {
    let myAge = 20
    let yourAge = 33
        print(Operators().text)

        if myAge < yourAge {
            "You are older than me"
        }else if myAge > yourAge {
            "I'm older than your"
        }else {
            "We are at the same age"
        }
        
        let myMotherAge = myAge + 30 //binary infix
        print(myMotherAge)

        
    }
    
    // 1. Unary prefix 
    let foo = !true
    // 2. Unary postfix
    let name = Optional("Ijaz")
    let unaryPostFix = name!
    // 3. Binary infix (between two variables or values)
    let result = 1 + 2
    let fullName = "Foo" + " " + "Bar"
    // 4.Ternary 
    let message = age >= 18
                ? "You are an adult"
                : "You are not yet an adult"
}
