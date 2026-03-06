import AVFoundation
import Foundation

class VectorScope {
    private let engine = AVAudioEngine()
    private let player = AVAudioPlayerNode()
    private let mixer = AVAudioMixerNode()
    private let varispeedNode: AVAudioUnitVarispeed = AVAudioUnitVarispeed()

    // UI Constants
    private let rows = 25
    private let cols = 120
    private let phosphorGreen = "\u{001B}[38;5;82m"
    private let reset = "\u{001B}[0m"

    // initializer instantiates engine fields
    init() {
        engine.attach(player)
        engine.attach(mixer)
        engine.attach(varispeedNode)
    }

    func start(song: Song, myRate: Float) {
        let path = (song.path.trimmingCharacters(in: .whitespaces) as NSString).expandingTildeInPath
        let url = URL(fileURLWithPath: path)

        guard let file = try? AVAudioFile(forReading: url) else {
            print("ERROR: File not found.")
            return
        }

        setRate(rate: myRate)
        setEffects(myFormat: file.processingFormat)

        //Create a buffer the size of the entire file
        let buffer = AVAudioPCMBuffer(
            pcmFormat: file.processingFormat,
            frameCapacity: AVAudioFrameCount(file.length))!

        // Read the file into that buffer
        try? file.read(into: buffer)

        // cshedule the buffer to play infinitely
        // The .loops gives loop option at buffer end
        player.scheduleBuffer(buffer, at: nil, options: .loops, completionHandler: nil)

        // ... rest of the setup (installTap, engine.start, etc.)
        mixer.installTap(onBus: 0, bufferSize: 1024, format: mixer.outputFormat(forBus: 0)) {
            [weak self] (buffer, _) in
            self?.renderLine(buffer: buffer)
        }

        print("\u{001B}[2J" + phosphorGreen)
        print("FILE: \(path)")
        print("TITLE: \(song.title)")
        print("RATE: \(varispeedNode.rate)x")
        print("LYRICS: \(song.lyrics)")

        try? engine.start()
        player.play()
        RunLoop.current.run()
    }

    func setRate(rate: Float) {
        let safeRate = max(0.25, min(rate, 4.0))
        varispeedNode.rate = safeRate
    }

    func setEffects(myFormat: AVAudioFormat) {
        engine.connect(player, to: varispeedNode, format: myFormat)
        engine.connect(varispeedNode, to: mixer, format: myFormat)
        engine.connect(mixer, to: engine.mainMixerNode, format: myFormat)
    }

    private func renderLine(buffer: AVAudioPCMBuffer) {
        guard let data = buffer.floatChannelData?[0] else { return }
        let frames = Int(buffer.frameLength)

        // Use a 2D array for the grid
        var grid = Array(repeating: Array(repeating: false, count: cols * 2), count: rows * 4)

        let step = frames / (cols * 2)
        var lastY: Int? = nil

        for x in 0..<(cols * 2) {
            let sample = data[x * step]
            let y = Int(((sample + 1.0) / 2.0) * Float(rows * 4 - 1))
            let clampedY = max(0, min(rows * 4 - 1, y))

            grid[clampedY][x] = true

            // Connect the dots: If the jump is large, fill in the vertical gaps
            if let previous = lastY {
                let start = min(previous, clampedY)
                let end = max(previous, clampedY)
                for fillY in start...end {
                    grid[fillY][x] = true
                }
            }
            lastY = clampedY
        }

        // Drawing using Braille characters
        var output = "\u{001B}[H" + phosphorGreen
        for r in stride(from: (rows * 4) - 4, through: 0, by: -4) {
            var rowStr = ""
            for c in stride(from: 0, to: (cols * 2), by: 2) {
                rowStr += getBraille(grid: grid, r: r, c: c)
            }
            output += "│" + rowStr + "│\n"
        }
        print(output + reset)
    }

    private func getBraille(grid: [[Bool]], r: Int, c: Int) -> String {
        var val = 0

        // Define the bit positions for the Braille Unicode block
        // These represent the 8 dots in a 2x4 Braille grid
        if grid[r + 0][c + 0] { val |= 1 }  // Dot 1
        if grid[r + 1][c + 0] { val |= 2 }  // Dot 2
        if grid[r + 2][c + 0] { val |= 4 }  // Dot 3
        if grid[r + 0][c + 1] { val |= 8 }  // Dot 4
        if grid[r + 1][c + 1] { val |= 16 }  // Dot 5
        if grid[r + 2][c + 1] { val |= 32 }  // Dot 6
        if grid[r + 3][c + 0] { val |= 64 }  // Dot 7
        if grid[r + 3][c + 1] { val |= 128 }  // Dot 8

        guard let scalar = UnicodeScalar(0x2800 + val) else { return " " }
        return String(scalar)
    }
}
