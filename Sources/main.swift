import Figlet
import Foundation

let app = VectorScope()
var choice: Song?
var myRate: Float?
let phosphorGreen: String = "\u{001B}[38;5;82m"

let options: [Song] = Library.sorted()

print(phosphorGreen)
Figlet.say("CLI-scillotor")
print("Song options:")
for (key, option) in options.enumerated() {
    print("\(key+1):\t\(option.title)")
}

print("Enter song number:")
if let s_index = readLine(),
    let i_index: Int = Int(s_index),
    i_index > 0 && i_index <= options.count
{
    choice = options[i_index - 1]

    print("You chose:")
    Figlet.say(choice!.title)
} else {
    print("Invalid input, try again.")
    exit(1)
}

print("Enter play rate:")
if let s_speed: String = readLine(),
    let f_speed: Float = Float(s_speed),
    f_speed > 0 && f_speed < 20
{
    myRate = f_speed
} else {
    print("Invalid input, try again.")
    exit(1)
}

app.start(song: choice!, myRate: myRate!)
