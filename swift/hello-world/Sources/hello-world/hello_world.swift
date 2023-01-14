import Foundation

@main
public struct hello_world {
    // public private(set) var text = "Hello, World!"

    public static func main() {
        // print(hello_world().text)
    
        let firstName: String = "Ijaz"
        let lastName: String = "Sharif"

        let names: [String]    = [
            firstName,
            lastName
        ]
        // names.append("Sequence")
        print(names)
    }
}

// print("Its working")

