import Figlet
import Foundation

let app = VectorScope()
var choice: Song?
var myRate: Float?
let phosphorGreen: String = "\u{001B}[38;5;82m"

let options: [Int: Song] = [
    1: Library.working,
    2: Library.blood,
    3: Library.brady,
    4: Library.fuji,
    5: Library.spare,
]

print(phosphorGreen)
Figlet.say("CLI-scillotor")
print("Song options:")
for (key, option) in options.sorted(by: { $0.key < $1.key }) {
    print("\(key):\t\(option.title)")
}

if let selection: String = readLine() {
    choice = options[Int(selection) ?? 1]
} else {
    print("invalid input")
    exit(1)
}

print("\nYou chose:")
Figlet.say(choice!.title)
print("\nRate: ")
if let speed: String = readLine() {
    myRate = Float(speed)
} else {
    print("invalid input")
    exit(1)
}

app.start(song: choice!, myRate: myRate!)
