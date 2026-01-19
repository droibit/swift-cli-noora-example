import ArgumentParser
import Noora

private enum OSType: CaseIterable, CustomStringConvertible {
  case iOS
  case watchOS

  var description: String {
    switch self {
    case .iOS: "iOS"
    case .watchOS: "watchOS"
    }
  }
}

private let iPhoneDevices = [
  "iPhone 17",
  "iPhone 16 Pro",
  "iPhone 16e",
  "iPhone 12",
  "iPhone SE",
]

private let watchDevices = [
  "Apple Watch Series 11",
  "Apple Watch Series 10",
  "Apple Watch Ultra 3",
  "Apple Watch SE 3",
]

struct SingleChoiceCommand: ParsableCommand {
  static let configuration = CommandConfiguration(
    commandName: "singlechoice",
    abstract: "Example command with a single choice"
  )

  // ref. https://noora.tuist.dev/components/prompts/single-choice
  mutating func run() throws {
    let noora = Noora()

    let selectedOS: OSType = noora.singleChoicePrompt(
      title: "Project",
      question: "Which operating system would you like to target?",
      description: "Select the target OS for the generated project.",
      autoselectSingleChoice: false
    )

    let deviceOptions: [String] = switch selectedOS {
    case .iOS: iPhoneDevices
    case .watchOS: watchDevices
    }

    let selectedDevice = noora.singleChoicePrompt(
      title: "Device",
      question: "Which device would you like to run the app on?",
      options: deviceOptions,
      description: "Select a device to simulate when running the app.",
      filterMode: .enabled,
      autoselectSingleChoice: false
    )

    noora.success(.alert("Selected: \(.primary(selectedDevice))"))
  }
}
