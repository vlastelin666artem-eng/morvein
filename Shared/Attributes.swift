import ActivityKit
import SwiftUI

struct MorveinAttributes: ActivityAttributes {
    struct ContentState: Codable, Hashable {
        var pose: String
        var mana: Int
        var hunger: Int
        var phrase: String
    }
    var name: String
}

extension Color {
    init(hex: UInt32) {
        self.init(red: Double((hex >> 16) & 255) / 255, green: Double((hex >> 8) & 255) / 255, blue: Double(hex & 255) / 255)
    }
}
